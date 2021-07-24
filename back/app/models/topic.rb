class Topic < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 300 }

  def self.search(search)
    Topic.where(['title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
  end
end
