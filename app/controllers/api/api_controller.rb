# frozen_string_literal: true

module Api
  # The ApiController class serves as the base controller for API endpoints, providing common functionality
  # such as error handling.
  class ApiController < ApplicationController
    include ErrorHandling

    # Class attribute that holds the default error status for the controller.
    class_attribute :error_status, default: :unprocessable_entity
  end
end
