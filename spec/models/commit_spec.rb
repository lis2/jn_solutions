require 'spec_helper'

describe Commit do
  it { should belong_to(:release) }
  it { should validate_uniqueness_of(:sha) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:commit_created_at) }
end

