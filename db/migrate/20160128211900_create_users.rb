class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      #TODO

      t.timestamps null: false
    end
  end
end
