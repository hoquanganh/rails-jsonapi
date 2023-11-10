class Author < ApplicationRecord
  has_many :articles

  validates :name, presence: true

  has_one_attached :image
end
