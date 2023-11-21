module ApiKeyAuthenticatable
  extend ActiveSupport::Concern

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_api_key
  attr_reader :current_bearer

  # Use this to raise an error and automatically respond with a 401 HTTP status
  # code when API key authentication fails
  def authenticate_with_api_key!
    # authenticate_or_request_with_http_token: authenticate with an HTTP token, otherwise automatically request authentication, i.e. Rails will respond with a 401 Unauthenticated HTTP status code.
    @current_bearer = authenticate_or_request_with_http_token &method(:authenticator)
  end

  # Use this for optional API key authentication
  def authenticate_with_api_key
    # authenticate_with_http_token: attempt to authenticate with an HTTP token, but don't raise an error if the token ends up being nil.
    @current_bearer = authenticate_with_http_token &method(:authenticator)
  end

  private

  attr_writer :current_api_key
  attr_writer :current_bearer

  def authenticator(http_token, options)
    @current_api_key = ApiKey.find_by(token_digest: http_token)

    current_api_key&.bearer
  end
end
