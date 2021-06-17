class Item < ApplicationRecord
  include Rails.application.routes.url_helpers

  START_HTTPS_LINK = /\Ahttps:\/\/[^\n]+\Z/
  belongs_to :user
  has_one_attached :image
  has_many :item_likes, dependent: :destroy
  has_many :item_comments, dependent: :destroy
  has_many :item_tag_maps, dependent: :destroy
  has_many :tags, through: :item_tag_maps

  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :link, format: { with: START_HTTPS_LINK, allow_blank: true }

  def image_url
    image.attached? ? url_for(image) : nil
  end

  def save_tags(sent_tags)
    sent_tags.each do |new_name|
      item_tag = Tag.find_or_create_by(name: new_name)
      self.tags << item_tag
    end
  end
end
