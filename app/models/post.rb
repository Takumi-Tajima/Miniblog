class Post < ApplicationRecord
  validates :contents, length: { maximum: 140 }
  default_order { order(:id) }
end
