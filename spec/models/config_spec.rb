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

    it "sets env to the ENV environment variable" do
      original_setting = ENV.delete("ENV")
      ENV["ENV"] = "test_env"
      expect(described_class.build.env).to eq("test_env")
      ENV["ENV"] = original_setting
    end

    it "sets database_file to the DATABASE_FILE environment variable" do
      old_setting = ENV.delete("DATABASE_FILE")
      ENV["DATABASE_FILE"] = "test/path/for/database.yml"
      expect(described_class.build.database_file).to eq("test/path/for/database.yml")
      ENV["DATABASE_FILE"] = old_setting
    end
  end
end
