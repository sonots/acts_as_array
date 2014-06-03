require 'rubygems'
require 'rspec'
require 'pry'
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'active_record'
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/sqlite.db'
)

#require 'rake'
#require_relative 'migrate_tasks'
#Rake::Task['db:schema:load'].invoke

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end
