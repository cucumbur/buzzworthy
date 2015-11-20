class AddGenreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :genre, :integer
  end
end
