class Tag < ApplicationRecord

  has_many :camp_item_tags, dependent: :destroy
  has_many :camp_items, through: :camp_item_tags

end
