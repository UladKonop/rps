# frozen_string_literal: true

# The ExtendedRpsGuessApiService module provides functionality to make an extended API call to retrieve a random Rock-Paper-Scissors guess,
# including an additional option: well.
module ExtendedRpsGuessApiService
  module_function

  # Makes an extended API call to retrieve a random RPS guess, including the 'well' option with a 25% probability.
  #
  # @return [String] - The random RPS guess (rock, paper, scissors, or well).
  def call
    return 'well' if rand(4).zero?

    ::RpsGuessApiService.call
  end
end
