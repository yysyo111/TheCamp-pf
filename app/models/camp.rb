class Camp < ApplicationRecord

  belongs_to :admin
  has_many :camp_comments, dependent: :destroy
  has_many :camp_favorites, dependent: :destroy
end
