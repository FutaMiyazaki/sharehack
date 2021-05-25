class Item < ApplicationRecord
  START_HTTPS_LINK = /\Ahttps:\/\/[^\n]+\Z/
  belongs_to :user

  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :link, format: { with: START_HTTPS_LINK, allow_blank: true }
  validates :price, presence: true
end
