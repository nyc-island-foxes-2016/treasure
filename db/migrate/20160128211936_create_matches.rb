class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer   :swipe1_id, index: true, null: false
      t.integer   :swipe2_id, index: true, null: false
      t.datetime  :swapped_at

      t.timestamps null: false
    end
  end
end
