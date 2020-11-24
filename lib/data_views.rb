module DataViews; end

Dir.glob(File.join(File.dirname(__FILE__), "views", "**", "*.rb")) { |file| require file }
