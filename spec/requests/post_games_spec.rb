require 'rails_helper'
# include ApiHelpers

RSpec.describe 'Games', type: :request do
  describe 'POST /create' do
    before(:each) do
      @stats = FactoryBot.create(:stats)
    end
    context 'with valid parameters' do
      let(:guesses) { %w[rock paper scissors well] }
      let(:users_guess_rock) { 'rock' }
      let(:users_guess_paper) { 'paper' }
      let(:users_guess_scissors) { 'scissors' }
      let(:users_guess_well) { 'well' }
      let(:expected_results_for_users) { ['You win!', 'You lost!', 'Tie'] }

      context 'random user guess' do
        before do
          post '/api/games', params:
            { guess: guesses.sample }
        end
        it 'returns :success response status' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'user guess: rock' do
        before do
          post '/api/games', params:
            { guess: users_guess_rock }
        end
        it 'returns correct response' do
          expect(expected_results_for_users.include?(json['result']['message'])).to eq(true)
        end
      end

      context 'user guess: paper' do
        before do
          post '/api/games', params:
            { guess: users_guess_paper }
        end
        it 'returns correct response' do
          expect(expected_results_for_users.include?(json['result']['message'])).to eq(true)
        end
      end

      context 'user guess: scissors' do
        before do
          post '/api/games', params:
            { guess: users_guess_scissors }
        end
        it 'returns correct response' do
          expect(expected_results_for_users.include?(json['result']['message'])).to eq(true)
        end
      end

      context 'user guess: well' do
        before do
          post '/api/games', params:
            { guess: users_guess_well }
        end
        it 'returns correct response' do
          expect(expected_results_for_users.include?(json['result']['message'])).to eq(true)
        end
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/games', params:
          { guess: 'guess' }
      end
      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
