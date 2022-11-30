# frozen_string_literal: true

module Api
  class GamesController < ApiController
    before_action :find_stats_instance, only: :create
    def create
      param! :guess, String, in: %w[rock paper scissors]

      @result = RpsService.new(guess: params[:guess]).call
      if @result
        update_statistics!
        render json: { result: @result, stats: @stats }, status: :ok
      else
        render json: { result: 'error' }, status: :unprocessable_entity
      end
    end

    private

    def update_statistics!
      @stats.update!(counter: @stats.counter + 1)
      case @result[:message]
      when 'You win!'
        @stats.update!(wins: @stats.wins + 1)
      when 'You lost!'
        @stats.update!(loses: @stats.loses + 1)
      end
      @stats.update!(percentage: (@stats.wins / @stats.counter.to_f * 100))
    end

    def find_stats_instance
      @stats = Stats.first
    end
  end
end
