class CreateCampItemFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_item_favorites do |t|
      
      t.integer :customer_id, null: false
      t.integer :camp_item_id, null: false

      t.timestamps
    end
  end
end
