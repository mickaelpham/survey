require 'sinatra'
require 'thin'
require 'json'

get '/hello' do
  [200, { 'Content-Type' => 'application/json' }, { hello: 'world' }.to_json]
end

module Stats
  def self.counter
    @counter ||= 0
  end

  def self.counter=(val)
    @counter = val
  end
end

post '/incr' do
  Stats.counter += 1

  [201, { 'Content-Type' => 'text/plain' }, Stats.counter.to_s]
end
