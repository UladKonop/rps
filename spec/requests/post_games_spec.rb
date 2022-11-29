require 'rails_helper'
# include ApiHelpers

RSpec.describe 'Games', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      let(:guesses) { %w[rock paper scissors] }
      let(:users_guess_rock) { 'rock' }
      let(:users_guess_paper) { 'paper' }
      let(:users_guess_scissors) { 'scissors' }
      let(:expected_results_for_users_rock) { [{"result"=>{"message"=>"You win!", "computer_guess"=>"scissors"}},{"result"=>{"message"=>"You lost!", "computer_guess"=>"paper"}},{"result"=>{"message"=>"Tie", "computer_guess"=>"rock"}}] }
      let(:expected_results_for_users_paper) { [{"result"=>{"message"=>"You lost!", "computer_guess"=>"scissors"}},{"result"=>{"message"=>"Tie", "computer_guess"=>"paper"}},{"result"=>{"message"=>"You win!", "computer_guess"=>"rock"}}] }
      let(:expected_results_for_users_scissors) { [{"result"=>{"message"=>"Tie", "computer_guess"=>"scissors"}},{"result"=>{"message"=>"You win!", "computer_guess"=>"paper"}},{"result"=>{"message"=>"You lost!", "computer_guess"=>"rock"}}] }

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
          expect(expected_results_for_users_rock.include?(json)).to eq(true)
        end
      end

      context 'user guess: paper' do
        before do
          post '/api/games', params:
            { guess: users_guess_paper }
        end
        it 'returns correct response' do
          expect(expected_results_for_users_paper.include?(json)).to eq(true)
        end
      end

      context 'user guess: scissors' do
        before do
          post '/api/games', params:
            { guess: users_guess_scissors }
        end
        it 'returns correct response' do
          expect(expected_results_for_users_scissors.include?(json)).to eq(true)
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
