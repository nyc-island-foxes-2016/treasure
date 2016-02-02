class AddAuthColumnsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :provider
      t.string :uid
    end
  end
end
