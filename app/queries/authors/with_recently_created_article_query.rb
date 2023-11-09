# Authors::WithRecentlyCreatedArticleQuery.call

module Authors
  class WithRecentlyCreatedArticleQuery
    DEFAULT_RANGE = 3.days

    def self.call(relation = Author.all, time_range: DEFAULT_RANGE)
      relation.
        joins(:articles).
        where('articles.created_at > ?', time_range.ago).
        distinct
    end
  end
end
