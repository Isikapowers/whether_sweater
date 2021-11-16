require 'rails_helper'

RSpec.describe "Roadtrip API" do
  describe 'POST roadtrip' do
    before(:each) do
      post '/api/v1/users', params: {
        "email": "ligma1@example.com",
        "password": "password",
        "password_confirmation": "password"
      }, as: :json

      @user_data = JSON.parse(response.body, symbolize_names: true)
    end

    it 'happy path: returns road trip info' do
      post '/api/v1/road_trip', params: {
        "origin": "Alexandria,VA",
        "destination": "Manassas,VA",
        "api_key": @user_data[:data][:attributes][:api_key]
      }, as: :json

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(body[:data]).to have_key(:id)
      expect(body[:data]).to have_key(:attributes)

      expect(body[:data][:attributes]).to have_key(:end_city)
      expect(body[:data][:attributes]).to have_key(:start_city)
      expect(body[:data][:attributes]).to have_key(:travel_time)
      expect(body[:data][:attributes]).to have_key(:weather_at_eta)
      expect(body[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(body[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    end

    it 'sad path: returns error message for invalid API key' do
      post '/api/v1/road_trip', params: {
        "origin": "Alexandria,VA",
        "destination": "Manassas,VA",
        "api_key": "thisisthewrongapikey"
      }, as: :json

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(body[:error]).to eq("Invalid API key")
    end
  end
end
