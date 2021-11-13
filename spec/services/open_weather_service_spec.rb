require 'rails_helper'

RSpec.describe 'OpenWeather API Service' do
  it 'can connect to open weather API with location given' do
    weather = VCR.use_cassette('get forcast') do
      OpenWeatherService.forecast_info('denver,co')
    end

    expect(weather).to be_a(Hash)
    expect(weather[:lat]).to be_a(Float)
    expect(weather[:lon]).to be_a(Float)

    expect(weather[:lat]).to eq(39.7385)
    expect(weather[:lon]).to eq(-104.9849)
    expect(weather[:lat]).to_not eq(35)
    expect(weather[:lon]).to_not eq(-100)

    expect(weather).to have_key(:current)
    expect(weather).to have_key(:daily)
    expect(weather).to have_key(:hourly)
  end
end
