class RpsService
  attr_writer :rand_seed

  def initialize(guess:)
    @guess = guess
  end

  def call
    if rule_engine[computer_guess.to_sym].include? @guess
      { message: 'You lost!', computer_guess: @computer_guess }
    elsif rule_engine[@guess.to_sym].include? computer_guess
      { message: 'You win!', computer_guess: @computer_guess }
    else
      { message: 'Tie', computer_guess: @computer_guess }
    end
  end

  private

  def randomization_algorithm
    rand 2342343
  end

  def computer_guess
    @computer_guess ||= api_call_computer_guess || offline_computer_guess
  end

  def api_call_computer_guess
    ::RpsGuessApiService.call
  end

  def offline_computer_guess
    srand (@rand_seed || randomization_algorithm)
    computer_guesses = %w{rock paper scissors}
    computer_guesses.sample
  end


  def rule_engine
    {
      'rock': ['scissors'],
      'paper': ['rock'],
      'scissors': ['paper']
    }
  end
end
