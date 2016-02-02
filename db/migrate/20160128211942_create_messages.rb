class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer   :match_id, index: true, null: false
      t.integer   :user_id, index: true, null: false
      t.text      :content, null: false, limit: 400
      t.timestamps null: false
    end
  end
end
