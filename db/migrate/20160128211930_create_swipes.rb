class CreateSwipes < ActiveRecord::Migration
  def change
    create_table :swipes do |t|
      t.integer :owned_item_id, null: false, index: true
      t.integer :judged_item_id, null: false, index: true
      t.string  :direction, null: false

      t.timestamps null: false
    end
  end
end
