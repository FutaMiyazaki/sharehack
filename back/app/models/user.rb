class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one_attached :avatar
  has_many :items, dependent: :destroy
  has_many :item_likes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
end
