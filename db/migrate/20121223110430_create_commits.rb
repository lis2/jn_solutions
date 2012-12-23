class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :sha
      t.string :author
      t.string :message
      t.datetime :commit_created_at
      t.integer :release_id
      t.timestamps
    end
  end
end
