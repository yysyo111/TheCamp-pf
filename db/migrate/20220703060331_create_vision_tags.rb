class CreateVisionTags < ActiveRecord::Migration[6.1]
  def change
    create_table :vision_tags do |t|
      t.string :name
      t.integer :camp_item_id

      t.timestamps
    end
  end
end
