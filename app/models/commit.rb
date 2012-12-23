class Commit < ActiveRecord::Base
  attr_accessible :sha, :author, :message, :commit_created_at

  validates_uniqueness_of :sha
  validates_presence_of :author
  validates_presence_of :message
  validates_presence_of :commit_created_at

  has_one :release

  scope :available, ->(release) { where("commit_created_at > ?", release.commit.commit_created_at) }
end
