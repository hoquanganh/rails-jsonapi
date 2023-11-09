class AuthorsController < ApplicationController
  before_action :find_author, only: :show

  def index
    @authors = Author.all
    render json: AuthorSerializer.new(@authors, serialize_options).serializable_hash
  end

  def show
    render json: AuthorSerializer.new(@author, serialize_options).serializable_hash
  end

  private

  def find_author
    @author = Author.find(params[:id])
  end

  def serialize_options
    { include: [:articles] }
  end
end
