# This migration comes from discussion (originally 20130501080604)
class CreateDiscussionCommentReads < ActiveRecord::Migration
  def change
    create_table :discussion_comment_reads do |t|
      t.integer :user_id
      t.integer :comment_id
      t.datetime :read_at

      t.timestamps
    end
  end
end
