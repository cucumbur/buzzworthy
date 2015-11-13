class CreateDunEvents < ActiveRecord::Migration
  def change
    create_table :dun_events do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
