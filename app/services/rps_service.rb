class RpsService
  attr_reader :rand_seed

  def initialize(guess:, rand_seed: 2342343)
    @guess = guess
    @rand_seed = rand_seed
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

  def computer_guess
    @computer_guess ||= api_call_computer_guess || offline_computer_guess
  end

  private

  def api_call_computer_guess
    ::RpsGuessApiService.call
  end

  def offline_computer_guess
    srand(rand_seed)
    computer_guesses = %w{rock paper scissors}
    computer_guesses.sample
  end


  def rule_engine
    {
      rock: ['scissors'],
      paper: ['rock'],
      scissors: ['paper']
    }
  end
end
