class Item < ApplicationRecord
  include Rails.application.routes.url_helpers

  START_HTTPS_LINK = /\Ahttps:\/\/[^\n]+\Z/
  belongs_to :user
  belongs_to :topic
  has_one_attached :image
  has_many :item_likes, dependent: :destroy
  has_many :item_comments, dependent: :destroy
  has_many :item_tag_maps, dependent: :destroy
  has_many :tags, through: :item_tag_maps

  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :link, format: { with: START_HTTPS_LINK, allow_blank: true }

  def image_url
    image.attached? ? url_for(image) : nil
  end

  def save_tags(sent_tags)
    current_tags = []
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    new_tags.each do |new|
      new_gadget_tag = Tag.find_or_create_by(name: new)
      self.tags << new_gadget_tag
    end
  end

  def self.search(search)
    Item.where(['name LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
  end
end
