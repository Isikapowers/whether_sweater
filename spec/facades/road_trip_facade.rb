require 'rails_helper'

RSpec.describe 'RoadTrip Facade' do
  it 'returns road trip details' do
    data = RoadTripFacade.road_trip_info('denver,co', 'estes park,co')

    expect(data).to be_a(RoadTripInfo)

    expect(data.id).to be(nil)
    expect(data.type).to eq('roadtrip')
    expect(data[:attributes].start_city).to eq('denver,co')
    expect(data[:attributes].end_city).to eq('estes park,co')
    # expect(data[:attributes].travel_time).to eq('')
    expect(data[:attributes].weather_at_eta).to have_key(:temperature)
    # expect(data[:attributes].weather_at_eta).to eq('')
    expect(data[:attributes].weather_at_eta).to have_key(:conditions)
    # expect(data[:attributes].weather_at_eta).to eq('')
  end

  it 'returns error when trip is impossible' do
    data = RoadTripFacade.road_trip_info("denver,co", "London,UK")

    expect(data).to be_a(RoadTripInfo)

    expect(data.start_city).to eq('denver,co')
    expect(data.end_city).to eq('London,UK')
    expect(data.travel_time).to eq('impossible route')

    expect(data.weather_at_eta).to have_key(:temperature)
    expect(data.weather_at_eta).to have_key(:conditions)

    expect(data.weather_at_eta[:temperature]).to eq(nil)
    expect(data.weather_at_eta[:conditions]).to eq(nil)
  end
end
