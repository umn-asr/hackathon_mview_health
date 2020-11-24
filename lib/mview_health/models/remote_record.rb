require "active_record"

module MviewHealth
  class RemoteRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
