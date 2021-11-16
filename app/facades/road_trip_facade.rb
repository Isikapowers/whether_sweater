class RoadTripFacade
  def self.road_trip_info(start_city, end_city)
    route = MapquestService.directions(start_city, end_city)
    forecast = ForecastFacade.get_forecast(end_city)
    travel_time = check_travel_time(route)
    time = check_time(route)

    route_details = {
      start_city: start_city,
      end_city: end_city,
      travel_time: travel_time,
      weather: forecast,
      time: time
    }

    RoadTripInfo.new(route_details)
  end

  def self.check_travel_time(route)
    route[:route][:formattedTime].split(':') if route[:route][:routeError][:errorCode] == (-400)
  end

  def self.check_time(route)
    Time.zone.now + route[:route][:realTime] if route[:route][:routeError][:errorCode] == (-400)
  end
end
