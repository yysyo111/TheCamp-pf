class CampItemComment < ApplicationRecord
  
  belongs_to :customer
  belongs_to :camp_item
end
