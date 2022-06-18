class CreateCampItems < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_items do |t|
      
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.text :impression, null: false
      t.float :rate
      
      t.timestamps
    end
  end
end
