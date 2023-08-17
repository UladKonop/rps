# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RpsGuessApiService do
  let(:guesses) { %w[rock paper scissors] }
  let!(:mock_api_url) { 'https://private-anon-2956a63b9a-curbrockpaperscissors.apiary-mock.com/rps-stage/throw' }

  context 'if remote server online' do
    it 'returns correct response' do
      expect(guesses.include?(described_class.call(url: mock_api_url))).to be(true)
    end
  end

  context 'if remote server offline' do
    before do
      allow(described_class).to receive(:call).and_return(nil)
    end

    it 'returns correct response' do
      expect(described_class.call).to be_nil
    end
  end
end
