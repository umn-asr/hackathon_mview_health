require "active_record"

module MviewHealth
  class RemoteRecord < ActiveRecord::Base
    # Error to raise if a concrete class does not set their view name
    class NoViewName < StandardError; end

    self.abstract_class = true

    def self.table_name
      view_or_table
    end

    class << self
      private

      attr_accessor :view_name

      def view_or_table
        raise NoViewName, "RemoteRecord classes must set their view_name" unless view_name

        if Rails.configuration.read_only_peoplesoft
          view_name
        else
          "test_#{view_name}"
        end
      end
    end
  end
end
