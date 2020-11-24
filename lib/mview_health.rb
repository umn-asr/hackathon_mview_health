# Top level namespace for the MviewHealth gem
module MviewHealth
end

Dir.glob(File.join(File.dirname(__FILE__), "mview_health", "**", "*.rb")) { |file| require file }
