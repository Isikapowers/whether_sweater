require 'rails_helper'

RSpec.describe 'Mapquest API Service' do
  it 'can connect to Mapquest API' do
    response = MapquestService.geocoding('denver,co')

    expect(response).to be_a(Hash)
    expect(response).to have_key(:results)
  end
end
