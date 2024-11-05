module Api
  module Concerns
    module Errors
      extend ActiveSupport::Concern

      included do
        rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      end

      def render_not_found
        render json: { error: "Not found" }, status: :not_found
      end

      def render_unprocessable_entity(errors)
        render "api/v1/errors", locals: { errors: }, status: :unprocessable_entity
      end
    end
  end
end
