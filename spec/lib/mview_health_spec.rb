require "ostruct"
require_relative "../../lib/mview_health"
# require_relative "../../lib/mview_metadata"

RSpec.describe MviewHealth::HealthCheck do
  let(:mview_metadata) { OpenStruct.new(name: "repeated_courses") }

  describe ".config" do
    context "when the configuration has not been set" do
      context "this is a Rails project" do
        before do
          # stub using rails
          module Rails; end
          # make sure doubles don't leak between tests
          MviewHealth.instance_variable_set(:@config, nil)
        end

        after do
          Object.send(:remove_const, :Rails)
        end

        it "builds a new configuration with rails defaults when rails is defined" do
          expected_config = instance_double(MviewHealth::Config)
          allow(MviewHealth::Config).to receive(:build_with_rails_defaults).and_return(expected_config)
          expect(MviewHealth.config).to eq(expected_config)
          expect(MviewHealth::Config).to have_received(:build_with_rails_defaults)
        end
      end

      context "the application is not a Rails project" do
        before do
          expect(Object.const_defined?(:Rails)).to be false
          # make sure doubles don't leak between tests
          MviewHealth.instance_variable_set(:@config, nil)
        end

        it "builds an empty configuration" do
          expected_config = instance_double(MviewHealth::Config)
          allow(MviewHealth::Config).to receive(:build).and_return(expected_config)
          expect(MviewHealth.config).to eq(expected_config)
          expect(MviewHealth::Config).to have_received(:build)
        end
      end
    end

    context "a configuration has been set" do
      let(:existing_config) { Object.new }

      before do
        MviewHealth.instance_variable_set(:@config, existing_config)
      end

      after do
        MviewHealth.instance_variable_set(:@config, nil)
      end

      it "returns an existing configuration" do
        expect(MviewHealth.config).to eq(existing_config)
      end
    end
  end

  describe ".configure" do
    it "yields the config to the block to be altered" do
      expect { |config| MviewHealth.configure(&config) }.to yield_with_args(MviewHealth.config)
    end
  end

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

  describe "default attributes" do
    it "uses MviewMetadata scopes for its default attributes" do
      expect(MviewHealth::MviewMetadata).to receive(:unusable).and_return([])

      described_class.new
    end
  end
end
