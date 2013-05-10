# This migration comes from discussion (originally 20130509100700)
class AddTopicToThreads < ActiveRecord::Migration
  def change
    add_column :discussion_threads, :topic_id, :integer
    add_column :discussion_threads, :topic_type, :string

    add_index :discussion_threads, :topic_id
    add_index :discussion_threads, :topic_type
  end
end
