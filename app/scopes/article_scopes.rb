module ArticleScopes
  def by_title(title)
    where("title LIKE ?", "%${title}%")
  end

  def by_author(author_id)
    where(author_id: author_id)
  end

  def newest
    order(created_at: :desc)
  end
end
