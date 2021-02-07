# frozen_string_literal: true

require 'json'
require 'pg'
require 'redis'
require 'sinatra/base'
require 'thin'
require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.inflector.inflect('kv_store' => 'KVStore')
loader.push_dir('app')
loader.setup

# Database.configure do |config|
#   config.host     = ENV.fetch('DB_HOST')
#   config.user     = ENV.fetch('DB_USER')
#   config.password = ENV.fetch('DB_PASSWORD')
#   config.dbname   = ENV.fetch('DB_NAME')
# end
