require 'rails_helper'

RSpec.describe 'Activities API' do
  describe "GET activities" do
    it 'has all the expected keys/attributes' do
      get '/api/v1/activities?destination=chicago,il'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data).to have_key(:id)
      expect(data[:id]).to eq('null')

      expect(data).to have_key(:type)
      expect(data[:type]).to eq('activities')

      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to have_key(:destination)

      expect(data[:attributes]).to have_key(:forecast)
      expect(data[:attributes][:forecast]).to have_key(:summary)
      expect(data[:attributes][:forecast]).to have_key(:temperature)

      expect(data[:attributes]).to have_key(:activities)
      expect(data[:attributes][:activities].first).to have_key(:title)
      expect(data[:attributes][:activities].first).to have_key(:type)
      expect(data[:attributes][:activities].first).to have_key(:participants)
      expect(data[:attributes][:activities].first).to have_key(:price)
    end

    it 'returns activity based on weather condition' do
      # forecast = use_cassette('get current forecast chicago') do
      #   ForecastFacade.get_forecast('chicago,il')
      # end

      allow_any_instanceof(ApplicationController).to receive(:current_weather[:temperature]).and_return(50)

      get '/api/v1/activities?destination=chicago,il'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data).to have_key(:id)
      expect(data[:id]).to eq('null')

      expect(data).to have_key(:type)
      expect(data[:type]).to eq('activities')

      expect(data[:attributes][:destination]).to eq('chicago,il')

      expect(data[:attributes][:forecast][:summary]).to eq('')
      expect(data[:attributes][:forecast][:temperature]).to eq()

      expect(data[:attributes][:activities].first[:title]).to have_key(:title)
      expect(data[:attributes][:activities].first).to have_key(:type)
      expect(data[:attributes][:activities].first).to have_key(:participants)
      expect(data[:attributes][:activities].first).to have_key(:price)
    end

    it 'returns error when no valid params given' do
      get '/api/v1/activities?destination='

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq('no valid params given')
    end
  end
end
