require 'spec_helper'

describe Release do
  before(:each) { GitHub.stub("make_zip").and_return("true") }
  it { should belong_to(:commit) }
  it { should validate_presence_of(:commit_id) }

  describe "commit validation" do
    let!(:release) { FactoryGirl.create(:release) }

    it "be valid" do
      release2 = FactoryGirl.build(:release)
      release2.commit.update_attribute(:commit_created_at, Time.now + 10.minutes)
      release2.should be_valid
    end

    it "not be valid" do
      release2 = FactoryGirl.build(:release)
      release2.commit.update_attribute(:commit_created_at, Time.now - 1.minute)
      release2.should_not be_valid
    end
  end
end
