class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.text :bio
      t.integer :level, default: 1
      t.integer :buzz, default: 0
      t.integer :max_motivation, default: 100
      t.integer :cur_motivation, default: 100
      t.integer :max_dignity, default: 20
      t.integer :cur_dignity, default: 20
      t.integer :max_strangepoints, default: 10
      t.integer :cur_strangepoints, default: 10

      t.timestamps null: false
    end
  end
end
