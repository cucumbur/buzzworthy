class AddStatsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verve, :integer, default: 2
		add_column :users, :heart, :integer, default: 2
    add_column :users, :allure, :integer, default: 2
    add_column :users, :strangeness, :integer, default: 2
    add_column :users, :serendipity, :integer, default: 2
  end
end
