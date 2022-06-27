class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :camp_items, dependent: :destroy
  has_many :camp_comments, dependent: :destroy
  has_many :camp_item_comments, dependent: :destroy
  has_many :camp_favorites, dependent: :destroy
  has_many :camp_item_favorites, dependent: :destroy

  # バリデーション
  validates :first_name, :last_name, :first_name_kana, :last_name_kana, presence: true

  # 退会済ユーザーをブロック
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/camp-icon.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.first_name = "guest"
      customer.last_name = "user"
      customer.first_name_kana = "ゲスト"
      customer.last_name_kana = "ユーザー"
    end
  end
end


