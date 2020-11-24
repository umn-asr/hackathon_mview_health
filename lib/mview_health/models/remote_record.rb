require "active_record"

module MviewHealth
  class RemoteRecord < ActiveRecord::Base
    self.abstract_class = true

    def self.table_name
      view_or_table
    end

    class << self
      private

      attr_accessor :view_name

      def view_or_table
        if Rails.configuration.read_only_peoplesoft
          view_name
        else
          "test_#{view_name}"
        end
      end
    end
  end
end
