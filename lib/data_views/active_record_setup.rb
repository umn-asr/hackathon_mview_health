require "active_record"
require_relative "../mview_health"
include ActiveRecord::Tasks

DatabaseTasks.root = DataViews.root
DatabaseTasks.env  = DataViews.environment

DatabaseTasks.database_configuration = YAML.load(File.read(MviewHealth.config.database_file))
ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
ActiveRecord::Base.establish_connection MviewHealth.config.env.to_sym
