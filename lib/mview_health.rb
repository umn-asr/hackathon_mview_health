# Top level namespace for the MviewHealth gem
module MviewHealth
  def self.config
    @config ||= if defined?(Rails)
                  Config.build_with_rails_defaults
                else
                  Config.build
                end
  end
end

Dir.glob(File.join(File.dirname(__FILE__), "mview_health", "**", "*.rb")) { |file| require file }
