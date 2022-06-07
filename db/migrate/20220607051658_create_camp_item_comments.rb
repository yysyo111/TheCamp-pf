class CreateCampItemComments < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_item_comments do |t|
      
      t.integer :customer_id, null: false
      t.integer :camp_item_id, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
