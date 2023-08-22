# frozen_string_literal: true

require 'net/http'
require 'json'

# The RpsGuessApiService module provides functionality to make an API call to retrieve a random Rock-Paper-Scissors guess.
module RpsGuessApiService
  # The URL of the API endpoint to retrieve the RPS guess.
  API_URL = 'https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw'

  # The timeout value for the API call, in seconds.
  TIMEOUT = '1'

  module_function

  # Makes an API call to the provided URL to retrieve a random RPS guess.
  #
  # @param [String] url - The URL of the API endpoint (optional, defaults to API_URL).
  # @return [String, nil] - The random RPS guess (rock, paper, or scissors) if successful, nil if the API call fails.
  def call(url: API_URL)
    uri = URI(url)
    res = Net::HTTP.get_response(uri)

    JSON(res.body)['body'] if res.is_a?(Net::HTTPSuccess)
  end
end
