# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    protect_from_forgery with: :null_session

    rescue_from RailsParam::InvalidParameterError, with: :invalid_parameter_error
    def invalid_parameter_error(exception)
      render json: {
        error: exception.message
      }, status: :unprocessable_entity
    end
  end
end
