class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :match_id, index: true, null: false

      t.timestamps null: false
    end
  end
end
