class Commit < ActiveRecord::Base
  attr_accessible :sha, :author, :message, :commit_created_at

  validates_uniqueness_of :sha
  validates_presence_of :author
  validates_presence_of :message
  validates_presence_of :commit_created_at

  belongs_to :release
end
