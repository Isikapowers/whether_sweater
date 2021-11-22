require 'rails_helper'

RSpec.describe 'RoadTrip Poros' do
  xit 'returns road trip objects', :vcr do
    data = VCR.use_cassette('loveland roadtrip') do
      RoadTripFacade.road_trip_info('denver,co', 'loveland,co')
    end

    expect(data).to be_a(RoadTripInfo)

    expect(data.id).to be(nil)
    expect(data.start_city).to eq('denver,co')
    expect(data.end_city).to eq('loveland,co')
    expect(data.travel_time).to eq('00 hours, 52 minutes')
    expect(data.weather_at_eta).to have_key(:temperature)
    expect(data.weather_at_eta[:temperature]).to eq('64.1 F')
    expect(data.weather_at_eta).to have_key(:conditions)
    expect(data.weather_at_eta[:conditions]).to eq('few clouds')

    expect(data.weather_at_eta).to_not have_key(:icon)
    expect(data.weather_at_eta).to_not have_key(:max_temp)
  end

  it 'sad path: returns less information if the road trip is impossible', :vcr do
    data = RoadTripFacade.road_trip_info("denver,co", "London,UK")

    expect(data).to be_a(RoadTripInfo)

    expect(data.start_city).to eq('denver,co')
    expect(data.end_city).to eq('London,UK')
    expect(data.travel_time).to eq('impossible route')

    expect(data.weather_at_eta).to have_key(:temperature)
    expect(data.weather_at_eta).to have_key(:conditions)

    expect(data.weather_at_eta[:temperature]).to eq('')
    expect(data.weather_at_eta[:conditions]).to eq('')

    expect(data.weather_at_eta).to_not have_key(:icon)
    expect(data.weather_at_eta).to_not have_key(:max_temp)
  end
end
