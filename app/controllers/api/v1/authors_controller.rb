class Api::V1::AuthorsController < ApiController
  before_action :find_author, only: :show

  def index
    @authors = Author.all
    render json: AuthorSerializer.new(@authors, serialize_options).serializable_hash
  end

  def show
    render json: AuthorSerializer.new(@author, serialize_options).serializable_hash
  end

  def create
    @author = Author.new(author_params)

    if @author.save!
      render json: json_serializer(@author), status: :created
    else
      render json: { status: false, error: @author.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @author.update(author_params)
      render json: json_serializer(@author), status: :ok
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  private

  def find_author
    @author = Author.find(params[:id])
  end

  def serialize_options
    { include: [:articles] }
  end

  def author_params
    params.require(:author).permit(:name, :email, :image)
  end
end
