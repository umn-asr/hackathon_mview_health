module MviewHealth
  class Config
    def self.build
      new
    end

    def self.build_with_rails_defaults
      env_vars = {
        "ENV" => Rails.env,
        "DATABASE_FILE" => File.join(Rails.root, "config", "database.yml")
      }

      new(env_vars: env_vars)
    end

    def initialize(env_vars: ENV)
      self.env_vars = env_vars
    end

    def env
      env_vars["ENV"]
    end

    def database_file
      env_vars["DATABASE_FILE"]
    end

    private

    attr_accessor :env_vars
  end
end
