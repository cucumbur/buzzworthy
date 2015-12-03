class AddFromIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :from_id, :integer
  end
end
