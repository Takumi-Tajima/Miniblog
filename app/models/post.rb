class Post < ApplicationRecord
  validates :content, length: { maximum: 140 }
  scope :default_order, -> { order(:id) }
end
