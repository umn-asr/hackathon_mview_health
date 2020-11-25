# setup database for those tests that need it
require "active_record"
# rubocop:disable Style/MixinUsage
include ActiveRecord::Tasks
# rubocop:enable Style/MixinUsage

DatabaseTasks.root                   = File.expand_path(File.join("..", ".."), __dir__)
DatabaseTasks.env                    = MviewHealth.config.env
DatabaseTasks.db_dir                 = File.join(DatabaseTasks.root, "spec", "support", "db")
DatabaseTasks.migrations_paths       = [File.join(DatabaseTasks.db_dir, "migrate")]
DatabaseTasks.database_configuration = YAML.safe_load(File.read(File.join(DatabaseTasks.root, "spec", "support", "database.yml")))
ActiveRecord::Base.configurations    = DatabaseTasks.database_configuration
ActiveRecord::Base.establish_connection(DatabaseTasks.database_configuration[DatabaseTasks.env])

require "active_record/connection_adapters/oracle_enhanced/database_tasks"
DatabaseTasks.migrate
