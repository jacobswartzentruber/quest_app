class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :name
      t.date :start_day
      t.integer :goal
      t.integer :last_record, default: 0

      t.timestamps null: false
    end
  end
end
