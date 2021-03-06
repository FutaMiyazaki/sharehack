class ItemLike < ApplicationRecord
  belongs_to :user
  belongs_to :item

  default_scope -> { order(created_at: :desc) }
  validates_uniqueness_of :item_id, scope: :user_id
  scope :filter_by_item, ->(item_id) { where(item_id: item_id) if item_id }
end
