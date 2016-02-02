class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string  :name, null: false, limit: 50
      t.string  :description, null: false, limit: 1000
      t.boolean :swapped, default: false
      t.integer :user_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
