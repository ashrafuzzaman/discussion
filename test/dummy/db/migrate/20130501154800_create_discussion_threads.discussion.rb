# This migration comes from discussion (originally 20130501074817)
class CreateDiscussionThreads < ActiveRecord::Migration
  def change
    create_table :discussion_threads do |t|
      t.string :subject
      t.integer :initiator_id
      t.datetime :last_posted_at
      t.integer :total_comments_post, default: 0

      t.timestamps
    end

    add_index :discussion_threads, :initiator_id
  end
end