require "./spec_helper"

describe PostProcess do
  it "has correct version number" do
    PostProcess::VERSION.should eq("0.1.0")
  end
end
