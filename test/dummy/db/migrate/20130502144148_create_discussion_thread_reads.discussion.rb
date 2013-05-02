# This migration comes from discussion (originally 20130502121352)
class CreateDiscussionThreadReads < ActiveRecord::Migration
  def change
    create_table :discussion_thread_reads do |t|
      t.integer :thread_id
      t.integer :user_id
      t.boolean :read, default: false

      t.timestamps
    end
    add_index :discussion_thread_reads, :thread_id
    add_index :discussion_thread_reads, :user_id
  end
end