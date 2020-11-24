module MviewHealth
  # This class checks that an Oracle mview has updated recently
  class HealthCheck
    def initialize(unusable_mviews:, out_of_date_mviews:)
      self.unusable_mviews = unusable_mviews
      self.out_of_date_mviews = out_of_date_mviews
    end

    def ok?
      unusable_mviews.none? && out_of_date_mviews.none?
    end

    def description
      if ok?
        "Up to date."
      else
        "Errored"
      end
    end

    def details
      if ok?
        "Everything up to date."
      else
        "The following data updates have errors: #{(unusable_mviews.map(&:name) + out_of_date_mviews.map(&:name)).join(" , ")}"
      end
    end

    private

    attr_accessor :unusable_mviews, :out_of_date_mviews
  end
end
