class Camp < ApplicationRecord

  belongs_to :admin
  has_many :camp_comments, dependent: :destroy
  has_many :camp_favorites, dependent: :destroy

  def camp_favorited_by?(customer)
    camp_favorites.exists?(customer_id: customer.id)
  end

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

  def get_camp_review_avg
    avg_rate = self.camp_comments.group("camp_comments.camp_id").average("camp_comments.rate").values.first
    if avg_rate > 4.5
      5
    elsif 4.0< avg_rate and avg_rate <= 4.5
      4.5
    elsif 3.5< avg_rate and avg_rate  <=4.0
      4.0
    elsif 3.0< avg_rate and avg_rate <=3.5
      3.5
    elsif 2.5< avg_rate and avg_rate <=3.0
      3.0
    elsif 2.0< avg_rate and avg_rate <=2.5
      2.5
    elsif 1.5< avg_rate and avg_rate <=2.0
      2.0
    elsif 1.0< avg_rate and avg_rate <=1.5
      1.5
    elsif 0.5 < avg_rate and avg_rate <=1.0
      1.0
    elsif 0< avg_rate and avg_rate <=0.5
      0.5
    else
      0
    end
  end
end


