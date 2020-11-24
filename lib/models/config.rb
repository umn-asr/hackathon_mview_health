module MviewHealth
  class Config
    def self.build
      new
    end

    def env
      ENV["ENV"]
    end

    def database_file
      ENV["DATABASE_FILE"]
    end
  end
end
