class Camp < ApplicationRecord

  belongs_to :admin
  has_many :camp_comments, dependent: :destroy
  has_many :camp_favorites, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # enum定義(カリキュラム参考)
  enum area: { hokkaido: 0, tohoku: 1, kanto: 2, chubu: 3, kinki: 4, chugoku: 5, shikoku: 6, kyushu: 7 }
end
