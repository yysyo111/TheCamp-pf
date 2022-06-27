class CampItem < ApplicationRecord

  belongs_to :customer
  has_many :camp_item_favorites, dependent: :destroy
  has_many :camp_item_comments, dependent: :destroy

  has_many :camp_item_tags, dependent: :destroy
  has_many :tags, through: :camp_item_tags

  # バリデーション
  validates :name, :impression, :rate, presence: true

  # いいね機能
  def camp_item_favorited_by?(customer)
    camp_item_favorites.exists?(customer_id: customer.id)
  end


  has_one_attached :camp_item_image

  def get_camp_item_image(width, height)
    unless camp_item_image.attached?
      file_path = Rails.root.join('app/assets/images/fire.jpg')
      camp_item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    camp_item_image.variant(resize_to_limit: [width, height]).processed
  end
end
