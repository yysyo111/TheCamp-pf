class Camp < ApplicationRecord

  belongs_to :admin
  has_many :camp_comments, dependent: :destroy
  has_many :camp_favorites, dependent: :destroy

  # バリデーション
  validates :name, :address, :phone_number, presence: true

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

  # レビューの平均の記述
  def get_camp_review_avg
    avg_rate = self.camp_comments.group("camp_comments.camp_id").average("camp_comments.rate").values.first
    avg_rate.nil? ? -1 : (avg_rate * 2).round / 2.0
    # 平均が空だった場合は(true)-1を返す。
    # また、投稿したけど評価が全て０だった場合は表示する。0だった場合とnilだった場合で分ける。(-1で分ける),三項演算子で分岐(true,false)
    #  falseの場合:avg_rateで合計の平均で出ている。その平均を、(avg_rate * 2).round / 2.0←ここで２倍にして四捨五入して、半分にした値がviewで出る
  end
end


