class CreateCampItems < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_items do |t|
      
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :location, null: false
      t.float :rate, null: false

      t.timestamps
    end
  end
end
