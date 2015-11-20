class AddUpgradePointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :upgrade_points, :integer, default: 0
  end
end
