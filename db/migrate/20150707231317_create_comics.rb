class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title, :cover_art_url
      t.integer :issue_number

      t.timestamps
    end
  end
end
