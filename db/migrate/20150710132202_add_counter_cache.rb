class AddCounterCache < ActiveRecord::Migration
  def change
    add_column :discussions, :reply_count, :integer, default: 0
  end
end
