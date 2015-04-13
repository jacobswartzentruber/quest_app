class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :name
      t.string :rank
      t.datetime :start_day
      t.integer :goal
      t.integer :last_record

      t.timestamps null: false
    end
  end
end
