# This migration comes from discussion (originally 20130501080150)
class CreateDiscussionComments < ActiveRecord::Migration
  def change
    create_table :discussion_comments do |t|
      t.integer :author_id
      t.integer :thread_id
      t.text :body

      t.timestamps
    end
    add_index :discussion_comments, :author_id
    add_index :discussion_comments, :thread_id
  end
end
