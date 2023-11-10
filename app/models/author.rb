class Author < ApplicationRecord
  has_many :articles

  validates :name, presence: true

  has_one_attached :image

  enum status: {
    pending: 0,
    active: 1,
    inactive: 2
  }
end
