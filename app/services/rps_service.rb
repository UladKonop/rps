# frozen_string_literal: true

# The RpsService class implements a Rock-Paper-Scissors (RPS) game service. It determines the result of the game
# between a player's guess and the computer's guess.
class RpsService
  # Messages to be displayed based on the game result.
  RESULT_MESSAGES = {
    win: 'You win!',
    loss: 'You lost!',
    tie: 'Tie'
  }.freeze

  # Rules of the RPS game. Each key represents a choice, and its associated value is an array of choices that the key beats.
  RULE_ENGINE = {
    rock: ['scissors'],
    paper: %w[rock well],
    scissors: ['paper'],
    well: %w[rock scissors]
  }.freeze

  # The random seed used for generating computer's guesses.
  attr_reader :rand_seed

  # Initializes the RpsService with the player's guess and an optional random seed.
  #
  # @param [Symbol] guess - The player's guess (:rock, :paper, :scissors, :well).
  # @param [Integer] rand_seed - Optional random seed for computer guess generation.
  def initialize(guess:, rand_seed: 2_342_343)
    @guess = guess
    @rand_seed = rand_seed
  end

  # Calls the RPS game logic and returns a hash containing the game result and computer's guess.
  #
  # @return [Hash] - The game result and computer's guess.
  def call
    {
      message: RESULT_MESSAGES[player_result],
      computer_guess: computer_guess
    }
  end

  # Retrieves the computer's guess either from an API call or from offline generation.
  #
  # @return [String] - The computer's guess.
  def computer_guess
    @computer_guess ||= api_call_computer_guess || offline_computer_guess
  end

  private

  # Determines the result of the game for the player based on their guess and computer's guess.
  #
  # @return [Symbol] - :win, :loss, or :tie.
  def player_result
    return :win if player_wins?
    return :loss if player_loses?

    :tie
  end

  # Checks if the player wins based on the game rules.
  #
  # @return [Boolean] - True if the player wins, false otherwise.
  def player_wins?
    RULE_ENGINE[@guess.to_sym].include?(computer_guess)
  end

  # Checks if the player loses based on the game rules.
  #
  # @return [Boolean] - True if the player loses, false otherwise.
  def player_loses?
    RULE_ENGINE[computer_guess.to_sym].include?(@guess)
  end

  # Calls an external service (ExtendedRpsGuessApiService) to get the computer's guess.
  #
  # @return [String, nil] - The computer's guess if successful, nil if the API call fails.
  def api_call_computer_guess
    ::ExtendedRpsGuessApiService.call
  end

  # Generates a random computer's guess when offline.
  #
  # @return [String] - The computer's guess.
  def offline_computer_guess
    srand(rand_seed)
    computer_guesses = %w[rock paper scissors well]
    computer_guesses.sample
  end
end
