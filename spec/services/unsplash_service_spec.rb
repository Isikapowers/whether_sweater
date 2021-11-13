require 'rails_helper'

RSpec.describe 'Unslash API Service' do
  it 'can connect to unsplash API' do
    response = UnsplashService.search_images("denver,co")

    expect(response).to be_a(Hash)
    expect(response[:results].first).to have_key(:urls)
    expect(response[:results].first[:urls]).to have_key(:regular)
    expect(response[:results].first[:links]).to have_key(:self)
    expect(response[:results].first).to have_key(:user)
    expect(response[:results].first[:user]).to have_key(:links)
    expect(response[:results].first[:user][:links]).to have_key(:self)
    expect(response[:results].first[:user]).to have_key(:username)
  end
end
