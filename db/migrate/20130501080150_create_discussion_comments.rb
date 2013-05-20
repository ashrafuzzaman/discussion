class CreateDiscussionComments < ActiveRecord::Migration
  def change
    create_table :discussion_comments do |t|
      t.integer :author_id
      t.integer :commentable_id
      t.string  :commentable_type, limit: 32
      t.text :body

      t.timestamps
    end
    add_index :discussion_comments, :author_id
    add_index :discussion_comments, :commentable_id
    add_index :discussion_comments, :commentable_type
  end
end
