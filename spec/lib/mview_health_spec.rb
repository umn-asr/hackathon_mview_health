require "ostruct"
require_relative "../../lib/mview_health"
# require_relative "../../lib/mview_metadata"

RSpec.describe MviewHealth::HealthCheck do
  let(:mview_metadata) { OpenStruct.new(name: "repeated_courses") }

  describe "#ok?" do
    it "is false when there is 1 or more unusuable mviews" do
      subject = described_class.new(
        unusable_mviews: [mview_metadata],
        out_of_date_mviews: []
      )

      expect(subject.ok?).to be false
    end

    it "is false when no there is 1 or more out_of_date mview" do
      subject = described_class.new(
        unusable_mviews: [],
        out_of_date_mviews: [mview_metadata]
      )

      expect(subject.ok?).to be false
    end

    it "is false when there are unusable and out_of_date mviews" do
      subject = described_class.new(
        unusable_mviews: [mview_metadata],
        out_of_date_mviews: [mview_metadata]
      )

      expect(subject.ok?).to be false
    end

    it "is true when there are no unusable or out_of_date mviews" do
      subject = described_class.new(
        unusable_mviews: [],
        out_of_date_mviews: []
      )

      expect(subject.ok?).to be true
    end
  end

  context "with errors" do
    describe "description and details" do
        it "mentions errors and the names of the errored mviews" do
            subject = described_class.new(
              unusable_mviews: [mview_metadata],
              out_of_date_mviews: []
            )

            expect(subject.ok?).to be false
            expect(subject.description).to include("Errored")
            expect(subject.details).to include("errors")
            expect(subject.details).to include(mview_metadata.name)
        end
      end
  end

  context "without errors" do
    describe "#details" do
      it "includes 'up to date'" do
        subject = described_class.new(
          unusable_mviews: [],
          out_of_date_mviews: []
        )

        expect(subject.description).to include("Up to date.")
        expect(subject.details).to include("Everything up to date.")
      end
    end
  end
end
