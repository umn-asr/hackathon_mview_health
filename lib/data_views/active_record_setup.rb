require "active_record"
include ActiveRecord::Tasks

DatabaseTasks.root = DataViews.root
DatabaseTasks.env  = DataViews.environment

DatabaseTasks.database_configuration = YAML.load(File.read(File.join(DatabaseTasks.root, "config", "database.yml")))
ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
