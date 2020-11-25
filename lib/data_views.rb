# module for Oracle views
module DataViews
  def self.root
    @root ||= File.expand_path(File.join("..", ".."), __FILE__)
  end

  def self.environment
    @environment ||= ENV['RAILS_ENV'] || ENV['ENV'] || "development"
  end

  def self.environment=(other)
    @environment = other
  end
end

require_relative "data_views/active_record_setup"
require "view_builder"

# require any additional libraries, initializers, the views might depend on here
# e.g. if you are using rails an your views use rails models, uncomment the line below
# require File.expand_path('../../config/environment', __FILE__)

Dir.glob(File.join(File.dirname(__FILE__), "data_views", "**", "*.rb")) { |file| require file }
