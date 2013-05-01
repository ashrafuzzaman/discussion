# This migration comes from discussion (originally 20130501080604)
class CreateDiscussionMessageReads < ActiveRecord::Migration
  def change
    create_table :discussion_message_reads do |t|
      t.integer :user_id
      t.integer :message_id
      t.datetime :read_at

      t.timestamps
    end
  end
end
