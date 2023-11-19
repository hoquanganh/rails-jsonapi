class ApiController < ApplicationController
  include Api::ExceptionRescue
  include Authenticable

  before_action :authenticate_user!
end
