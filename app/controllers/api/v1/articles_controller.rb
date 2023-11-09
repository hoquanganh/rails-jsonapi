class Api::V1::ArticlesController < ApiController
  before_action :find_article, only: %i(show update destroy)

  def index
    @articles = Article.all

    render json: json_serializer(@articles.preload(:author))
  end

  def show
    render json: json_serializer(@article)
  end

  def create
    @article = Article.new(article_params)

    if @article.save!
      render json: json_serializer(@article), status: :created
    else
      render json: { status: false, error: @article.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      render json: json_serializer(@article), status: :ok
    else
      render json: { status: false, error: @article.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    render json: { status: true, data: @article }, status: :ok
  end

  private

  def find_article
    @article = Article.find_by!(id: params[:id])
  end

  def serialize_options
    { include: [:author]}
  end

  def json_serializer(records)
    ArticleSerializer.new(records, serialize_options).serializable_hash
  end

  def article_params
    params.require(:article).permit(:title, :body, :author_id)
  end

end
