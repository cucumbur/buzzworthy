class AddEventsToDungeons < ActiveRecord::Migration
  def change
    add_column :dungeons, :events, :string, default: ""
  end
end
