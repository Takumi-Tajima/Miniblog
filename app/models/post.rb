class Post < ApplicationRecord
  validates :contents, length: { maximum: 140 }
end
