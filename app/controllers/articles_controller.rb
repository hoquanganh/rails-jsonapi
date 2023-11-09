class ArticlesController < ApplicationController
  before_action :find_article, only: :show

  def index
    @articles = Article.all

    render json: ArticleSerializer.new(
      @articles.preload(:author),
      serialize_options
    ).serializable_hash
  end

  def show
    render json: ArticleSerializer.new(@article, serialize_options).serializable_hash
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def serialize_options
    { include: [:author]}
  end
end
