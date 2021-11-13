require 'rails_helper'

RSpec.describe 'Mapquest Facade' do
  it 'can get a latitude and longtitude for a location' do
    response = MapquestFacade.get_coordinates('denver,co')

    expect(response).to be_a(Hash)
    expect(response[:lat]).to be_a(Float)
    expect(response[:lng]).to be_a(Float)

    expect(response).to have_key(:lat)
    expect(response).to have_key(:lng)

    expect(response[:lat]).to eq(39.738453)
    expect(response[:lng]).to eq(-104.984853)
    expect(response[:lat]).to_not eq(36)
    expect(response[:lng]).to_not eq(-100)
  end
end
