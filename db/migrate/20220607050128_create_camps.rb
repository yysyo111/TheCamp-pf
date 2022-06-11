class CreateCamps < ActiveRecord::Migration[6.1]
  def change
    create_table :camps do |t|
      
      t.integer :admin_id, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.integer :phone_number, null: false
      t.integer :area, null: false, default: 0
      t.float :latitude
      t.float :longitude
      t.boolean :parking, null: false, default: true

      t.timestamps
    end
  end
end
