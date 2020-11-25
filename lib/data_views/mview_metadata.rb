# Module to hold all view_builder views
module DataViews
  # View of 'unusable' and 'last_refresh_time' for mviews used to evaluate their health
  class MviewMetadata
    def self.view_name
      "mview_metadata"
    end

    def self.definition_sql
      <<~SQL
        SELECT
          mview_name as name,
          last_refresh_date,
          unusable
        FROM
          user_mview_analysis
      SQL
    end
  end
end
