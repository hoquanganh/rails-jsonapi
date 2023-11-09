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
    end
  end
end
