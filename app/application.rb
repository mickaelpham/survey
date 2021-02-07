class Application < Sinatra::Application
  get '/hello' do
    [200, { 'Content-Type' => 'application/json' }, { hello: 'world' }.to_json]
  end

  post '/incr' do
    count = KVStore.incr(:my_counter)

    [201, { 'Content-Type' => 'text/plain' }, count.to_s]
  end

  get '/products' do
    [
      200,
      { 'Content-Type' => 'application/json' },
      { products: Product.all.map(&:to_h) }.to_json
    ]
  end
end
