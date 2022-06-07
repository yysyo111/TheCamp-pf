class CreateCampFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_favorites do |t|
      
      t.integer :camp_id, null: false
      t.integer :customer_id, null: false

      t.timestamps
    end
  end
end
