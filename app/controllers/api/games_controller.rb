module Api
  class GamesController < ApiController
    def create
      param! :guess, String, in: %w(rock paper scissors)

      result = RpsService.new(guess: params[:guess]).call
      if result
        render json: { result: result }, status: :ok
      else
        render json: { result: 'error' }, status: :unprocessable_entity
      end
    end
  end
end
