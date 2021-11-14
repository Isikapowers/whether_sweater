require 'rails_helper'

RSpec.describe 'Forecast API' do
  describe 'GET forecast', :vcr do
    it 'returns the forecast for a specific location' do
      headers = { 'CONTENT_TYPE' => 'application/json' }

      get '/api/v1/forecast?location=denver,co', headers: headers

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(forecast[:id]).to eq(nil)
      expect(forecast[:type]).to eq('forecast')
      expect(forecast[:attributes]).to have_key(:current_weather)
      expect(forecast[:attributes]).to have_key(:daily_weather)
      expect(forecast[:attributes]).to have_key(:hourly_weather)

      expect(forecast[:attributes][:current_weather]).to have_key(:datetime)
      expect(forecast[:attributes][:current_weather]).to have_key(:sunrise)
      expect(forecast[:attributes][:current_weather]).to have_key(:sunset)
      expect(forecast[:attributes][:current_weather]).to have_key(:temperature)
      expect(forecast[:attributes][:current_weather]).to have_key(:feels_like)
      expect(forecast[:attributes][:current_weather]).to have_key(:humidity)
      expect(forecast[:attributes][:current_weather]).to have_key(:uvi)
      expect(forecast[:attributes][:current_weather]).to have_key(:visibility)
      expect(forecast[:attributes][:current_weather]).to have_key(:conditions)
      expect(forecast[:attributes][:current_weather]).to have_key(:icon)
      expect(forecast[:attributes][:current_weather]).to_not have_key(:pressure)
      expect(forecast[:attributes][:current_weather]).to_not have_key(:clouds)
      expect(forecast[:attributes][:current_weather]).to_not have_key(:rain)

      expect(forecast[:attributes][:daily_weather].count).to eq(5)

      forecast[:attributes][:daily_weather].each do |day|
        expect(day).to have_key(:date)
        expect(day).to have_key(:sunrise)
        expect(day).to have_key(:sunset)
        expect(day).to have_key(:max_temp)
        expect(day).to have_key(:min_temp)
        expect(day).to have_key(:conditions)
        expect(day).to have_key(:icon)
        expect(day).to_not have_key(:humidity)
        expect(day).to_not have_key(:moonrise)
        expect(day).to_not have_key(:pressure)
      end

      expect(forecast[:attributes][:hourly_weather].count).to eq(8)

      forecast[:attributes][:hourly_weather].each do |hour|
        expect(hour).to have_key(:time)
        expect(hour).to have_key(:temperature)
        expect(hour).to have_key(:conditions)
        expect(hour).to have_key(:icon)
        expect(hour).to_not have_key(:feels_like)
        expect(hour).to_not have_key(:humidity)
        expect(hour).to_not have_key(:dew_point)
      end
    end

    it 'returns an error when params not given' do
      headers = { 'CONTENT_TYPE' => 'application/json' }

      get '/api/v1/forecast?location=', headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      # expect(response[:error]).to eq('valid params not given')
    end
  end
end
