class CreateDiscussionConcerns < ActiveRecord::Migration
  def change
    create_table :discussion_concerns do |t|
      t.integer :user_id
      t.integer :discussion_thread_id

      t.timestamps
    end

    add_index :discussion_concerns, :user_id
    add_index :discussion_concerns, :discussion_thread_id
  end
end