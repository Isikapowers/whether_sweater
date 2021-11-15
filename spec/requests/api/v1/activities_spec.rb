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

    it 'returns cooking activity when temp is below 50 F', :vcr do
      VCR.use_cassette('weather below 50') do
        ForecastFacade.get_forecast('chicago,il')
      end

      get '/api/v1/activities?destination=chicago,il'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data).to have_key(:id)
      expect(data[:id]).to eq('null')

      expect(data).to have_key(:type)
      expect(data[:type]).to eq('activities')

      expect(data[:attributes][:destination]).to eq('chicago,il')

      expect(data[:attributes][:forecast][:summary]).to eq('light snow')
      expect(data[:attributes][:forecast][:temperature]).to eq('33.1 F')

      expect(data[:attributes][:activities].first[:title]).to eq('Write a list of things you are grateful for')
      expect(data[:attributes][:activities].first[:type]).to eq('relaxation')
      expect(data[:attributes][:activities].first[:participants]).to eq(1)
      expect(data[:attributes][:activities].first[:price]).to eq(0)

      expect(data[:attributes][:activities].second[:title]).to eq('Create a cookbook with your favorite recipes')
      expect(data[:attributes][:activities].second[:type]).to eq('cooking')
      expect(data[:attributes][:activities].second[:participants]).to eq(1)
      expect(data[:attributes][:activities].second[:price]).to eq(0)
    end

    it 'returns busywork activity when temp is between 50-60 F', :vcr do
      VCR.use_cassette('weather between 50 and 60') do
        ForecastFacade.get_forecast('la')
      end

      get '/api/v1/activities?destination=denver.co'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data).to have_key(:id)
      expect(data[:id]).to eq('null')

      expect(data).to have_key(:type)
      expect(data[:type]).to eq('activities')

      expect(data[:attributes][:destination]).to eq('denver.co')

      expect(data[:attributes][:forecast][:summary]).to eq('overcast clouds')
      expect(data[:attributes][:forecast][:temperature]).to eq('43.03 F')

      expect(data[:attributes][:activities].first[:title]).to eq('Shop at support your local farmers market')
      expect(data[:attributes][:activities].first[:type]).to eq('relaxation')
      expect(data[:attributes][:activities].first[:participants]).to eq(1)
      expect(data[:attributes][:activities].first[:price]).to eq(0.2)

      expect(data[:attributes][:activities].second[:title]).to eq('Bake pastries for you and your neighbor')
      expect(data[:attributes][:activities].second[:type]).to eq('busywork')
      expect(data[:attributes][:activities].second[:participants]).to eq(1)
      expect(data[:attributes][:activities].second[:price]).to eq(0)
    end

    it 'returns recreational activity when temp is more than 60F', :vcr do
      VCR.use_cassette('weather more than 60') do
        ForecastFacade.get_forecast('miami,fl')
      end

      get '/api/v1/activities?destination=miami,fl'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data).to have_key(:id)
      expect(data[:id]).to eq('null')

      expect(data).to have_key(:type)
      expect(data[:type]).to eq('activities')

      expect(data[:attributes][:destination]).to eq('miami,fl')

      expect(data[:attributes][:forecast][:summary]).to eq('overcast clouds')
      expect(data[:attributes][:forecast][:temperature]).to eq('76.73 F')

      expect(data[:attributes][:activities].first[:title]).to eq('Give your pet ten minutes of focused attention')
      expect(data[:attributes][:activities].first[:type]).to eq('relaxation')
      expect(data[:attributes][:activities].first[:participants]).to eq(1)
      expect(data[:attributes][:activities].first[:price]).to eq(0)

      expect(data[:attributes][:activities].second[:title]).to eq('Paint the first thing you see')
      expect(data[:attributes][:activities].second[:type]).to eq('recreational')
      expect(data[:attributes][:activities].second[:participants]).to eq(1)
      expect(data[:attributes][:activities].second[:price]).to eq(0.25)
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
