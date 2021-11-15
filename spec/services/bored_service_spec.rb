require 'rails_helper'

RSpec.describe 'Bored API' do
  describe "#initialize" do
    it 'can connect to bored api endpoint' do
      response = BoredService.search_random_activity('relaxation')

      expect(response).to be_a(Hash)

      expect(response).to have_key(:activity)
      expect(response).to have_key(:type)
      expect(response).to have_key(:participants)
      expect(response).to have_key(:price)
    end
  end
end
