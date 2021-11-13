class OpenWeatherService < BaseService
  def self.forecast_info(location)
    coordinates = MapquestFacade.get_coordinates(location)

    response = Faraday.get('http://api.openweathermap.org/data/2.5/onecall') do |req|
      req.params['appid'] = ENV['OPEN_WEATHER_KEY']
      req.params['lat'] = coordinates[:lat]
      req.params['lon'] = coordinates[:lng]
      req.params['units'] = 'imperial'
      req.headers['Content-Type'] = 'application/json'
    end
    parse_json(response)
  end
end
