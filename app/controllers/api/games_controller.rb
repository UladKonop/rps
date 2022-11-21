module Api
  class GamesController < ApiController
    def create
      render json: { result: RpsService.new(guess: params[:guess]).call}
    end
  end
end
