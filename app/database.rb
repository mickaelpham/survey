module Database
  class << self
    def conn
      @conn ||= PG.connect(host: ENV.fetch('DB_HOST'),
                           user: ENV.fetch('DB_USER'),
                           password: ENV.fetch('DB_PASSWORD'),
                           dbname: ENV.fetch('DB_NAME'))
    end
  end
end
