class Post < ApplicationRecord
  validates :contents, length: { maximum: 140 }
  scope :default_order, -> { order(:id) }
end
