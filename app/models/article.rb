class Article < ApplicationRecord
  extend ArticleScopes

  belongs_to :author
end
