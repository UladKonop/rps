# frozen_string_literal: true

module RpsGuessApiService
  API_URL = 'https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw'
  TIMEOUT = '1'

  module_function

  def call(url: API_URL)
    uri = URI(url)
    res = Net::HTTP.get_response(uri)

    JSON(res.body)['body'] if res.is_a?(Net::HTTPSuccess)
  end
end
