class CampComment < ApplicationRecord
  
  belongs_to :customer
  belongs_to :camp
end
