class CreateCampComments < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_comments do |t|
      
      t.integer :camp_id, null: false
      t.integer :customer_id, null: false
      t.float :rate
      t.text :comment, null: false
      t.string :title, null: false 

      t.timestamps
    end
  end
end
