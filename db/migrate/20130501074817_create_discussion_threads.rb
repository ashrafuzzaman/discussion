class CreateDiscussionThreads < ActiveRecord::Migration
  def change
    create_table :discussion_threads do |t|
      t.string :subject
      t.integer :initiator_id

      t.timestamps
    end

    add_index :discussion_threads, :initiator_id
  end
end