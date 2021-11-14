require 'rails_helper'

RSpec.describe 'Sessions' do
  before :each do
    @user = User.create!({ email: 'user@example.com',
                           password: 'password',
                           password_confirmation: 'password' })
  end

  describe 'POST new session' do
    it 'creates new session' do
      session_params = {
        email: 'user@example.com',
        password: 'password'
      }

      post '/api/v1/sessions', params: session_params, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data).to be_a(Hash)
      expect(data[:type]).to eq('users')
      expect(data).to have_key(:id)
      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to have_key(:email)
      expect(data[:attributes]).to have_key(:api_key)
      expect(data[:attributes][:api_key]).to eq(@user.api_key)
    end

    it 'returns an error when credentials are incorrect' do
      session_params = {
        email: 'user@example.com',
        password: 'password1234'
      }

      post '/api/v1/sessions', params: session_params, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq('Credentials are invalid.  Please try again.')
    end
  end
end
