class CreateToReadItems < ActiveRecord::Migration
  def change
    create_table :to_read_items do |t|
      t.integer :user_id, :comic_id, :list_position

      t.timestamps
    end
  end
end
