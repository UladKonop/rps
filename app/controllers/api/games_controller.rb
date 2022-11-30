module Api
  class GamesController < ApiController
    def create
      param! :guess, String, in: %w(rock paper scissors)
      @stats = Stats.first

      result = RpsService.new(guess: params[:guess]).call
      if result
        @stats.update!(counter: @stats.counter + 1)
        if result[:message] == 'You win!'
          @stats.update!(wins: @stats.wins + 1)
        elsif result[:message] == 'You lost!'
          @stats.update!(loses: @stats.loses + 1)
        end
        @percentage = @stats.wins /  @stats.counter.to_f * 100

        render json: { result: result, stats: @stats, percentage: @percentage}, status: :ok
      else
        render json: { result: 'error' }, status: :unprocessable_entity
      end
    end
  end
end
