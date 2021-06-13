class Tag < ApplicationRecord
  has_many :items, through: :item_tag_maps
  has_many :item_tag_maps, dependent: :destroy, foreign_key: 'tag_id'

  validates :name, presence: true, length: { maximum: 20 }
end
