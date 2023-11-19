module Authenticable
  private

  def authenticate_user!
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    else
      render json: { message: "Unauthorized" }, status: :unauthorized
    end
  end
end
