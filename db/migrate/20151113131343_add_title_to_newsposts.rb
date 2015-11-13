class AddTitleToNewsposts < ActiveRecord::Migration
  def change
    add_column :newsposts, :title, :string
  end
end
