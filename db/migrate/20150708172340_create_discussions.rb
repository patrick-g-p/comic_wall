class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.text :body
      t.integer :user_id, :comic_id

      t.timestamps
    end
  end
end
