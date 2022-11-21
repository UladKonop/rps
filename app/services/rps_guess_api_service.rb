module RpsGuessApiService
  API_URL = 'https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw'
  Mock_API_URL = 'https://private-anon-2956a63b9a-curbrockpaperscissors.apiary-mock.com/rps-stage/throw'
  TIMEOUT = '1'

  module_function

  def call
    uri = URI(API_URL)
    res = Net::HTTP.get_response(uri)

    JSON(res.body)['body'] if res.is_a?(Net::HTTPSuccess)
  end
end
