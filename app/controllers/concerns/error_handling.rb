# frozen_string_literal: true

# The ErrorHandling module provides common error handling functionality for controllers.
module ErrorHandling
  extend ActiveSupport::Concern

  included do
    protect_from_forgery with: :null_session
    rescue_from RailsParam::InvalidParameterError, with: :handle_invalid_parameter_error
  end

  private

  # Handles an InvalidParameterError exception by rendering an error response.
  #
  # @param [RailsParam::InvalidParameterError] exception - The exception representing the invalid parameter error.
  def handle_invalid_parameter_error(exception)
    render_error(exception.message, self.class.error_status)
  end

  # Renders an error response with the provided message and status.
  #
  # @param [String] message - The error message to be included in the response.
  # @param [Symbol] status - The HTTP status code for the error response.
  def render_error(message, status)
    error_message = { error: message }
    render json: error_message, status: status
  end
end
