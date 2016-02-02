class AddAvatarColumnsToItems < ActiveRecord::Migration
  def up
    add_attachment :items, :avatar
  end

  def down
    remove_attachment :items, :avatar
  end
end
