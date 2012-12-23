class Release < ActiveRecord::Base
  attr_accessible :commit_id

  belongs_to :commit

  validates_presence_of :commit_id
  validate :valid_commit?

  after_create :create_zip
  def create_zip
    GitHub.make_zip(self.commit.sha)
  end

  private
  def valid_commit?
    errors.add(:commit_id, "wrong commit") if Release.last.present? && Release.last.commit.commit_created_at >= self.commit.commit_created_at
  end
end
