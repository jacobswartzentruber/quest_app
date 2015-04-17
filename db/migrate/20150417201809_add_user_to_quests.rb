class AddUserToQuests < ActiveRecord::Migration
  def change
    add_reference :quests, :user, index: true, foreign_key: true
  end
end
