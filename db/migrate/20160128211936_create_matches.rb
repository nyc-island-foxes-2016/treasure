class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer   :given_swipe_id, index: true, null: false
      t.integer   :received_swipe_id, index: true, null: false
      t.datetime  :swapped_at

      t.timestamps null: false
    end
  end
end
