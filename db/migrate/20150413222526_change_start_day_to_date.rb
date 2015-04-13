class ChangeStartDayToDate < ActiveRecord::Migration
  def change
  	change_column :quests, :start_day, :date
  end
end
