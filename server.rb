require 'json'
require 'redis'
require 'sinatra'
require 'thin'

module KeyValueStore
  class << self
    def incr(counter)
      provider.incr(counter)
    end

    private

    def provider
      @provider ||= Redis.new(host: 'redis')
    end
  end
end

get '/hello' do
  [200, { 'Content-Type' => 'application/json' }, { hello: 'world' }.to_json]
end

post '/incr' do
  count = KeyValueStore.incr(:my_counter)

  [201, { 'Content-Type' => 'text/plain' }, count.to_s]
end

post '/another-incr' do
  count = KeyValueStore.incr(:another_counter)

  [201, { 'Content-Type' => 'application/json' }, { success: true, value: count }.to_json]
end
