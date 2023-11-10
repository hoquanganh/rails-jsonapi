module Api
  module ExceptionRescue
    extend ActiveSupport::Concern

    included do
      # handle response for RecordInvalid API
      rescue_from ActiveRecord::RecordInvalid, with: :render_invalidation_response

      def render_invalidation_response exception
        render json: exception.record, serializer: Api::Errors::ValidationErrorsSerializer,
          status: :bad_request
      end

      # handle response for RecordNotFound API
      rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
      def render_record_not_found_response exception
        render json: Api::Errors::ActiveRecordNotFound.new(exception).to_hash, status: :not_found
      end

      # Other errors handle
      rescue_from(Unauthorized) do |exception|
        render json: { errors: "Unauthorized" }, status: 401
      end
      rescue_from(UnprocessableEntity) do |exception|
        render json: { errors: "Unprocessable Entity" }, status: 422
      end
      rescue_from(BadRequest) do |exception|
        render json: { errors: "There's something wrong with your request" }, status: 400
      end

      rescue_from(Forbidden) do |_exception|
        render json: { errors: "You are not allowed" }, status: 403
      end
    end
  end
end
