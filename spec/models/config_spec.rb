require "spec_helper"
require_relative "../../lib/mview_health/models/config"

RSpec.describe MviewHealth::Config do
  describe ".build_with_rails_defaults" do
    before do
      # stub using Rails
      module Rails
        def self.env
          "config_test"
        end

        def self.root
          File.expand_path(__dir__)
        end
      end
    end

    after do
      Object.send(:remove_const, :Rails)
    end

    it "sets the env to Rails.env" do
      subject = described_class.build_with_rails_defaults
      expect(subject.env).to eq("config_test")
    end

    it "sets the database_file to Rails root + config + database.yml" do
      subject = described_class.build_with_rails_defaults
      expect(subject.database_file).to eq(File.join(File.expand_path(__dir__), "config", "database.yml"))
    end
  end

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
