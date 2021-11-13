require 'rails_helper'

RSpec.describe 'Background API' do
  describe 'GET background image for the city' do
    it 'returns the image for the city' do
      headers = { 'CONTENT_TYPE' => 'application/json' }

      get '/api/v1/backgrounds?location=denver,co', headers: headers

      expect(response).to be_successful

      image = JSON.parse(response.body, symbolize_names: true)

      expect(image[:data][:type]).to eq('image')
      expect(image[:data][:attributes]).to have_key(:image)
      expect(image[:data][:attributes][:image]).to have_key(:location)
      expect(image[:data][:attributes][:image]).to have_key(:image_url)
      expect(image[:data][:attributes][:image]).to have_key(:credit)
      expect(image[:data][:attributes][:image][:credit]).to have_key(:source)
      expect(image[:data][:attributes][:image][:credit]).to have_key(:author)
      expect(image[:data][:attributes][:image][:credit]).to have_key(:profile)
    end

    it 'returns an error when no params given' do
      get '/api/v1/backgrounds?location='

      image = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(400)
      expect(response).to_not be_successful
      expect(image[:error]).to eq('cannot find background image')
    end
  end
end
