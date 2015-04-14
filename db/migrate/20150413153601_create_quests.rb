class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :name
      t.string :rank, default: "\"Newborn\""
      t.date :start_day, default: Date.today
      t.integer :goal
      t.integer :last_record, default: 0

      t.timestamps null: false
    end
  end
end
