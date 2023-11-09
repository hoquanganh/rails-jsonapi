class Article < ApplicationRecord
  extend ArticleScopes

  belongs_to :author
  validates :author_id, presence: true
end
