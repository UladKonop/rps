# frozen_string_literal: true

module Api
  # The GamesController class handles API requests related to the game, including creating new game instances
  # and updating statistics.
  class GamesController < ApiController
    before_action :find_stats_instance, only: :create

    # Creates a new game instance based on the provided guess parameter.
    #
    # @param [String] guess - The player's guess (rock, paper, scissors, or well).
    def create
      param! :guess, String, in: %w[rock paper scissors well]

      @result = RpsService.new(guess: params[:guess], rand_seed: DateTime.now.to_i).call
      if @result
        update_statistics!
        render json: { result: @result, stats: @stats }, status: :ok
      else
        render json: { result: 'error' }
      end
    end

    private

    # Updates the game statistics based on the result of the game.
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

    # Finds the statistics instance for the game.
    def find_stats_instance
      @stats = Stats.first
    end
  end
end
