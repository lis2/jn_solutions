class CorrectRelationBetweenCommitsAndReleases < ActiveRecord::Migration
  def up
    add_column :releases, :commit_id, :integer
    remove_column :commits, :release_id
  end

  def down
    remove_column :releases, :commit_id
    add_column :commits, :release_id, :integer
  end
end
