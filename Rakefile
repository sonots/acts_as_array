# coding: utf-8
require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = ["-c", "-f progress"] # '--format specdoc'
      t.pattern = 'spec/**/*_spec.rb'
end
task :test => :spec
task :default => :spec

desc 'Open an irb session preloaded with the gem library'
task :console do
  sh 'irb -rubygems -I lib -I spec -r acts_as_array -r spec_helper -r model'
end
task :c => :console

require 'active_record'
require 'logger'
 
namespace :db do
  MIGRATIONS_DIR = 'db/migrate'
  SCHEMA_FILE    = 'db/schema.rb'
  DB_FILE        = 'db/sqlite.db'
 
  # connect the database
  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => DB_FILE
  )
 
  # outpt logs
  ActiveRecord::Base.logger = Logger.new(STDOUT)
 
  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Migrator.migrate(MIGRATIONS_DIR, ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end
 
  desc 'Roll back the database schema to the previous version'
  task :rollback do
    ActiveRecord::Migrator.rollback(MIGRATIONS_DIR, ENV['STEP'] ? ENV['STEP'].to_i : 1)
  end

  namespace :schema do
    desc "Create a db/schema.rb file that can be portably used against any DB supported by AR"
    task :dump do
      require 'active_record/schema_dumper'
      File.open(ENV['SCHEMA'] || SCHEMA_FILE, "w") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end

    desc "Load a schema.rb file into the database"
    task :load do
      file = ENV['SCHEMA'] || SCHEMA_FILE
      load(file)
    end
  end
end
