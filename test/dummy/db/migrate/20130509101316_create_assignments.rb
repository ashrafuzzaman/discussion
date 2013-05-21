class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.string :description
      t.string :text
      t.integer :total_comments_post, default: 0

      t.timestamps
    end
  end
end
