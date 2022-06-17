class CampComment < ApplicationRecord

  belongs_to :customer
  belongs_to :camp

  # バリデーション
  validates :comment, :title, :rate, presence: true

end
