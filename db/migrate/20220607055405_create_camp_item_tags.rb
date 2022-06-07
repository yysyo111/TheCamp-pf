class CreateCampItemTags < ActiveRecord::Migration[6.1]
  def change
    create_table :camp_item_tags do |t|
      
      t.integer :camp_item_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
