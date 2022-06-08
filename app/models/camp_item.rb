class CampItem < ApplicationRecord
  
  belongs_to :cunstomers
  has_many :camp_item_favorites, dependent: :destroy
  has_many :camp_item_comments, dependent: :destroy
  
end
