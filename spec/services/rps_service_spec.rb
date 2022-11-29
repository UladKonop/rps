require 'rails_helper'

RSpec.describe RpsService do
  context 'RpsApiService is up' do
    context 'RpsApiService returns rock' do
      before do
        allow(RpsGuessApiService).to receive(:call).and_return('rock')
      end
      it { expect(described_class.new(guess: 'paper').call).to eq(message: 'You win!', computer_guess: 'rock') }
      it { expect(described_class.new(guess: 'scissors').call).to eq(message: 'You lost!', computer_guess: 'rock') }
      it { expect(described_class.new(guess: 'rock').call).to eq(message: 'Tie', computer_guess: 'rock') }
    end
    context 'RpsApiService returns paper' do
      before do
        allow(RpsGuessApiService).to receive(:call).and_return('paper')
      end
      it { expect(described_class.new(guess: 'paper').call).to eq(message: 'Tie', computer_guess: 'paper') }
      it { expect(described_class.new(guess: 'scissors').call).to eq(message: 'You win!', computer_guess: 'paper') }
      it { expect(described_class.new(guess: 'rock').call).to eq(message: 'You lost!', computer_guess: 'paper') }
    end
    context 'RpsApiService returns scissors' do
      before do
        allow(RpsGuessApiService).to receive(:call).and_return('scissors')
      end
      it { expect(described_class.new(guess: 'paper').call).to eq(message: 'You lost!', computer_guess: 'scissors') }
      it { expect(described_class.new(guess: 'scissors').call).to eq(message: 'Tie', computer_guess: 'scissors') }
      it { expect(described_class.new(guess: 'rock').call).to eq(message: 'You win!', computer_guess: 'scissors') }
    end
  end
  context 'RpsApiService is down' do
    before do
      allow(RpsGuessApiService).to receive(:call).and_return(nil)
    end
    context 'computer guess is rock' do
      let(:rand_seed) { 2 }
      it { expect(described_class.new(guess: 'paper', rand_seed: rand_seed).call).to eq(message: 'You win!', computer_guess: 'rock') }
      it { expect(described_class.new(guess: 'scissors', rand_seed: rand_seed).call).to eq(message: 'You lost!', computer_guess: 'rock') }
      it { expect(described_class.new(guess: 'rock', rand_seed: rand_seed).call).to eq(message: 'Tie', computer_guess: 'rock') }
    end
    context 'computer guess is paper' do
      let(:rand_seed) { 1 }
      it { expect(described_class.new(guess: 'paper', rand_seed: rand_seed).call).to eq(message: 'Tie', computer_guess: 'paper') }
      it { expect(described_class.new(guess: 'scissors', rand_seed: rand_seed).call).to eq(message: 'You win!', computer_guess: 'paper') }
      it { expect(described_class.new(guess: 'rock', rand_seed: rand_seed).call).to eq(message: 'You lost!', computer_guess: 'paper') }
    end
    context 'computer guess is scissors' do
      let(:rand_seed) { 3 }
      it { expect(described_class.new(guess: 'paper', rand_seed: rand_seed).call).to eq(message: 'You lost!', computer_guess: 'scissors') }
      it { expect(described_class.new(guess: 'scissors', rand_seed: rand_seed).call).to eq(message: 'Tie', computer_guess: 'scissors') }
      it { expect(described_class.new(guess: 'rock', rand_seed: rand_seed).call).to eq(message: 'You win!', computer_guess: 'scissors') }
    end
  end
end
