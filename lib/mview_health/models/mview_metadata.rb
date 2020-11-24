require_relative "remote_record"
require_relative "../../views/mview_metadata"

module MviewHealth
  class MviewMetadata < RemoteRecord
    self.view_name = DataViews::MviewMetadata.view_name

    scope :unusable, -> { where(unusable: "Y") }
    scope :last_refreshed_before, ->(cutoff) { where("last_refresh_date < ?", cutoff.strftime("%Y-%m-%d %H:%M:%S")) }
  end
end
