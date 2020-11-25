require_relative "remote_record"
require_relative "../../data_views/mview_metadata"

module MviewHealth
  # tracks metadata about materialized views so we can check their health
  class MviewMetadata < RemoteRecord
    self.view_name = DataViews::MviewMetadata.view_name

    scope :unusable, -> { where(unusable: "Y") }
    scope :last_refreshed_before, ->(cutoff) { where("last_refresh_date < ?", cutoff.strftime("%Y-%m-%d %H:%M:%S")) }
  end
end
