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
