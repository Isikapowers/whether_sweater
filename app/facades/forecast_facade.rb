class ForecastFacade
  def self.get_forecast(coordinates)
    data = OpenWeatherService.forecast_info(coordinates)
    ForecastInfo.new(data)
  end
end
