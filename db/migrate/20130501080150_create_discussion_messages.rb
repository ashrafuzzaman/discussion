class CreateDiscussionMessages < ActiveRecord::Migration
  def change
    create_table :discussion_messages do |t|
      t.integer :author_id
      t.text :body

      t.timestamps
    end
    add_index :discussion_messages, :author_id
  end
end
