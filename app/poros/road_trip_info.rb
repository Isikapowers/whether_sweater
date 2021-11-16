class RoadTripInfo
  attr_reader :id, :start_city, :end_city,
              :travel_time, :weather_at_eta

  def initialize(data)
    @id = nil
    @start_city = data[:start_city]
    @end_city = data[:end_city]
    @travel_time = format_time(data)
    @weather_at_eta = format_weather(data)
  end

  private

  def format_time(data)
    if data[:time].nil?
      'impossible route'
    elsif data[:time] < (Time.zone.now + 288_000)
      "#{data[:travel_time][0]} hours, #{data[:travel_time][1]} minutes"
    end
  end

  def format_weather(data)
    if data[:time].nil?
      {
        temperature: '',
        conditions: ''
      }
    elsif data[:time] < (Time.zone.now + 288_000)
      eta_forecast = data[:weather].hourly_weather.find do |hour|
        hour[:time].to_i == data[:time].hour
      end
      {
        temperature: "#{eta_forecast[:temperature].round(1)} F",
        conditions: eta_forecast[:conditions]
      }
    end
  end
end
