require "spec_helper"
require_relative "../../lib/models/config"

RSpec.describe MviewHealth::Config do
  describe ".build" do
    it "returns a new config" do
      new_config = instance_double(described_class)
      allow(described_class).to receive(:new).and_return(new_config)
      expect(described_class.build).to eq(new_config)
      expect(described_class).to have_received(:new).with(no_args)
    end
  end
end
