class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.text :bio
      t.integer :level
      t.integer :buzz
      t.integer :max_motivation
      t.integer :cur_motivation
      t.integer :max_dignity
      t.integer :cur_dignity
      t.integer :max_strangepoints
      t.integer :cur_strangepoints

      t.timestamps null: false
    end
  end
end
