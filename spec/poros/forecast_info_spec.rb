require 'rails_helper'

RSpec.describe 'Forecast Poros' do
  describe "#initialize" do
    it "exists and returns forecast info object" do
      info = VCR.use_cassette('forecast_info') do
        ForecastFacade.get_forecast('denver')
      end

      expect(info).to be_a(ForecastInfo)
      expect(info.id).to eq(nil)
      expect(info.current_weather).to have_key(:datetime)
      expect(info.current_weather).to have_key(:sunrise)
      expect(info.current_weather).to have_key(:sunset)
      expect(info.current_weather).to have_key(:temperature)
      expect(info.current_weather).to have_key(:feels_like)
      expect(info.current_weather).to have_key(:humidity)
      expect(info.current_weather).to have_key(:uvi)
      expect(info.current_weather).to have_key(:visibility)
      expect(info.current_weather).to have_key(:conditions)
      expect(info.current_weather).to have_key(:icon)

      expect(info.current_weather).to_not have_key(:date)
      expect(info.current_weather).to_not have_key(:max_temp)
      expect(info.current_weather).to_not have_key(:min_temp)

      expect(info.daily_weather.first).to have_key(:date)
      expect(info.daily_weather.first).to have_key(:sunrise)
      expect(info.daily_weather.first).to have_key(:sunset)
      expect(info.daily_weather.first).to have_key(:max_temp)
      expect(info.daily_weather.first).to have_key(:min_temp)
      expect(info.daily_weather.first).to have_key(:conditions)
      expect(info.daily_weather.first).to have_key(:icon)

      expect(info.daily_weather.first).to_not have_key(:uvi)
      expect(info.daily_weather.first).to_not have_key(:visibility)
      expect(info.daily_weather.first).to_not have_key(:feels_like)

      expect(info.hourly_weather.first).to have_key(:time)
      expect(info.hourly_weather.first).to have_key(:temperature)
      expect(info.hourly_weather.first).to have_key(:conditions)
      expect(info.hourly_weather.first).to have_key(:icon)

      expect(info.hourly_weather.first).to_not have_key(:min_temp)
      expect(info.hourly_weather.first).to_not have_key(:feels_like)
      expect(info.hourly_weather.first).to_not have_key(:sunset)
    end
  end
end
