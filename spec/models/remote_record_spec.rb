require "spec_helper"
require_relative "../../lib/mview_health/models/remote_record"

RSpec.describe MviewHealth::RemoteRecord do
  before :all do
    # stub using Rails
    module Rails
    end
  end

  it "is an abstract class" do
    expect(described_class.abstract_class).to be true
  end
end
