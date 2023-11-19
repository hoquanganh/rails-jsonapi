Rails.application.configure do
  config.session_store :cookie_store, key: '_rails_jsonapi_session', expire_after: 60.minutes
  config.middleware.use ActionDispatch::Cookies
  config.middleware.use config.session_store, config.session_options
end
