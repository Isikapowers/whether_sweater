require 'rails_helper'

RSpec.describe 'Users API' do
  before :each do
    User.destroy_all
  end

  describe 'POST new user' do
    it 'creats user in the database' do
      user_params = {
        email: 'lucy@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post '/api/v1/users', params: user_params, as: :json

      expect(response).to be_successful
      expect(response).to have_http_status(201)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data).to have_key(:id)
      expect(data[:type]).to eq('users')
      expect(data[:attributes]).to have_key(:email)
      expect(data[:attributes]).to have_key(:api_key)

      expect(data[:attributes]).to_not have_key(:password)
      expect(data[:attributes]).to_not have_key(:password_confirmation)
    end

    it 'returns an error if email is blank' do
      user_params = {
        email: '',
        password: 'password',
        password_confirmation: 'password'
      }

      post '/api/v1/users', params: user_params, as: :json

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)
      expect(data[:error].first).to eq("Email can't be blank")
    end

    it 'returns an error if password is blank' do
      user_params = {
        email: 'loolo@gmail.com',
        password: '',
        password_confirmation: 'password'
      }

      post '/api/v1/users', params: user_params, as: :json

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)
      expect(data[:error]).to eq(["Password can't be blank"])
    end

    it 'returns an error if password is blank' do
      user_params = {
        email: 'lula@gmail.com',
        password: 'password',
        password_confirmation: ''
      }

      post '/api/v1/users', params: user_params, as: :json

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)
      expect(data[:error]).to eq(["Password confirmation doesn't match Password"])
    end

    it 'returns an error if password confirmation does not match' do
      user_params = {
        email: 'lorwy@gmail.com',
        password: 'password',
        password_confirmation: 'password123'
      }

      post '/api/v1/users', params: user_params, as: :json

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)
      expect(data[:error]).to eq(["Password confirmation doesn't match Password"])
    end
  end

  describe 'FIND user by email' do
    it 'returns user when search by email' do
      user = User.create({email: 'user@example.com',
                          password: 'password',
                          password_confirmation: 'password'
                        })

      get '/api/v1/users?email=user@example.com'

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful

      expect(data).to be_a(Array)
      expect(data.first[:attributes][:email]).to eq(user.email)
    end

    it 'returns error when no email given' do
      User.create({email: 'user@example.com',
                          password: 'password',
                          password_confirmation: 'password'
                        })

      get '/api/v1/users?email='

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      
      expect(data[:error]).to eq('no valid email given')
    end
  end
end
