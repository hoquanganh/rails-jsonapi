class ArticleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :body
  belongs_to :author
end
