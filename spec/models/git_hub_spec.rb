require 'spec_helper'
require 'ostruct'

describe GitHub do
  before(:each) {  }

  it "check if limit exceeded" do
    HTTParty.stub("get").and_return(OpenStruct.new(code: 200))
    GitHub.limit_exceeded?.should == false
  end

  it "alert if limit exceeded" do
    HTTParty.stub("get").and_return(OpenStruct.new(code: 400, message: "exceeded"))
    GitHub.limit_exceeded?.should == true
  end
end

