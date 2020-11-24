module MviewHealth
  class Config
    def self.build
      new
    end

    def env
      ENV["ENV"]
    end
  end
end
