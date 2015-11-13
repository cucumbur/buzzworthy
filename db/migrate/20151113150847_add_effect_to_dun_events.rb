class AddEffectToDunEvents < ActiveRecord::Migration
  def change
    add_column :dun_events, :effect, :string
  end
end
