require 'rails_helper'

RSpec.describe 'RoadTrip Poros' do
  it 'returns road trip objects', :vcr do
    data = RoadTripFacade.road_trip_info('denver,co', 'loveland,co')

    expect(data).to be_a(RoadTripInfo)

    expect(data.id).to be(nil)
    expect(data.start_city).to eq('denver,co')
    expect(data.end_city).to eq('loveland,co')
    expect(data.travel_time).to eq('00 hours, 52 minutes')
    expect(data.weather_at_eta).to have_key(:temperature)
    expect(data.weather_at_eta[:temperature]).to eq('66.2 F')
    expect(data.weather_at_eta).to have_key(:conditions)
    expect(data.weather_at_eta[:conditions]).to eq('few clouds')
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
  end
end
