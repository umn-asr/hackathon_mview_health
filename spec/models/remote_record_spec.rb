require "spec_helper"
require "ostruct"
require_relative "../../lib/mview_health/models/remote_record"

RSpec.describe MviewHealth::RemoteRecord do
  it "is an abstract class" do
    expect(described_class.abstract_class).to be true
  end

  describe "concrete implementations" do
    # test class that works
    class ConcreteRemoteRecord < MviewHealth::RemoteRecord
      self.view_name = "test"
    end

    describe "#table_name" do
      context "when Rails.configuration.read_only_peoplesoft is true" do
        before do
          # stub using Rails
          module Rails
            def self.configuration
              OpenStruct.new(read_only_peoplesoft: true)
            end
          end
        end

        it "uses the view_name" do
          expect(ConcreteRemoteRecord.table_name).to eq("test")
        end
      end

      context "when Rails.configuration.read_only_peoplesoft is false" do
        before do
          # stub using Rails
          module Rails
            def self.configuration
              OpenStruct.new(read_only_peoplesoft: false)
            end
          end
        end

        it "prefixes the view name with test" do
          expect(ConcreteRemoteRecord.table_name).to eq("test_test")
        end
      end
    end
  end
end
