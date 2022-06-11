class Camp < ApplicationRecord

  belongs_to :admin
  has_many :camp_comments, dependent: :destroy
  has_many :camp_favorites, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # enum定義(カリキュラム参考)
  enum area: { hokkaido: 0, tohoku: 1, kanto: 2, chubu: 3, kinki: 4, chugoku: 5, shikoku: 6, kyushu: 7 }

  # キャンプ場の画像追加
  has_one_attached :camp_image

  def get_camp_image(width, height)
    unless camp_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      camp_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    camp_image.variant(resize_to_limit: [width, height]).processed
  end
end
