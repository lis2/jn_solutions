require 'spec_helper'
require 'ostruct'

describe Commit do

  it { should have_one(:release) }
  it { should validate_uniqueness_of(:sha) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:commit_created_at) }

  describe "available commits" do
    let!(:commit) { FactoryGirl.create(:commit) }

    it "doesnt return" do
      release = OpenStruct.new(commit: OpenStruct.new(commit_created_at: Time.now + 10.minute))
      Commit.available(release).size.should == 0
    end

    it "returns available" do
      release = OpenStruct.new(commit: OpenStruct.new(commit_created_at: Time.now - 10.minute))
      Commit.available(release).size.should == 1
    end
  end
end
