class Tag < ApplicationRecord
  has_many :item_tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :items, through: :item_tag_maps

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true

  def self.search(search)
    Tag.where(['name LIKE ?', "%#{search}%"])
  end
end
