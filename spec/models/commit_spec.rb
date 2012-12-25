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
    let(:release_timestamp) { Time.now }
    let(:release) { stub }

    before { release.stub_chain('commit.commit_created_at').
              and_return(release_timestamp) }
    subject { Commit.available(release) }

    context 'when there is none' do
      let(:release_timestamp) { Time.now - 10.minute }
      it { should == [ commit ] }
    end

    context 'when there is one' do
      let(:release_timestamp) { Time.now + 10.minute }
      it { should be_empty }
    end

  end
end
