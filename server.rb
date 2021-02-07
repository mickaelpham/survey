# frozen_string_literal: true

require 'json'
require 'pg'
require 'redis'
require 'sinatra'
require 'thin'

module DB
  class << self
    def conn
      @conn ||= PG.connect(host: ENV.fetch('DB_HOST'),
                           user: ENV.fetch('DB_USER'),
                           password: ENV.fetch('DB_PASSWORD'),
                           dbname: ENV.fetch('DB_NAME'))
    end
  end
end

module KVStore
  class << self
    def incr(counter)
      provider.incr(counter)
    end

    private

    def provider
      @provider ||= Redis.new(host: ENV.fetch('REDIS_HOST'))
    end
  end
end

class Product
  ATTRIBUTES = %i[
    id
    name
    description
  ].freeze

  class << self
    def all
      DB.conn.exec('SELECT * FROM product') do |exec_result|
        exec_result.each_with_object([]) do |row, result|
          result << create_from_db(row)
        end
      end
    end

    def create_from_db(row)
      new.tap do |instance|
        ATTRIBUTES.each do |attr|
          instance.public_send(:"#{attr}=", row[attr.to_s])
        end
      end
    end
  end

  ATTRIBUTES.each do |attr|
    attr_accessor(attr)
  end

  def to_h
    ATTRIBUTES.each_with_object({}) do |attr, result|
      result[attr] = send(attr)
    end
  end
end

get '/hello' do
  [200, { 'Content-Type' => 'application/json' }, { hello: 'world' }.to_json]
end

post '/incr' do
  count = KVStore.incr(:my_counter)

  [201, { 'Content-Type' => 'text/plain' }, count.to_s]
end

get '/products' do
  [200, { 'Content-Type' => 'application/json' }, { products: Product.all.map(&:to_h) }.to_json]
end
