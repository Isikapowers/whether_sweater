require 'rails_helper'

RSpec.describe 'Forecast Facade' do
  it 'returns forecast details' do
    response = ForecastFacade.get_forecast('denver,co')

    expect(response).to be_a(ForecastInfo)
    expect(response.current_weather).to be_a(Hash)
    expect(response.daily_weather).to be_a(Array)
    # expect(response).to have_key(:hourly_weather)
  end
end
