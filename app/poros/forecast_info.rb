class ForecastInfo
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

    def initialize(details)
      @id = details[:id]
      @current_weather = get_current_weather(details[:current])
      @daily_weather = get_daily_weather(details[:daily][0..4])
      @hourly_weather = get_hourly_weather(details[:hourly][0..7])
    end

    private

    def get_current_weather(data)
      {
        datetime: Time.zone.at(data[:dt]).to_s(:dt),
        sunrise: Time.zone.at(data[:sunrise]).to_s(:time),
        sunset: Time.zone.at(data[:sunset]).to_s(:time),
        temperature: data[:temp],
        feels_like: data[:feels_like],
        humidity: data[:humidity],
        uvi: data[:uvi],
        visibility: data[:visibility],
        conditions: data[:weather][0][:description],
        icon: data[:weather][0][:icon]
      }
    end

    def get_daily_weather(data)
      data.map do |day|
        {
          date: Time.zone.at(day[:dt]).to_date,
          sunrise: Time.zone.at(day[:sunrise]).to_s(:time),
          sunset: Time.zone.at(day[:sunset]).to_s(:time),
          max_temp: day[:temp][:max],
          min_temp: day[:temp][:min],
          conditions: day[:weather][0][:description],
          icon: day[:weather][0][:icon]
        }
      end
    end

  def get_hourly_weather(data)
    data.map do |hour|
      {
        time: Time.zone.at(hour[:dt]).to_s(:time),
        temperature: hour[:temp],
        conditions: hour[:weather][0][:description],
        icon: hour[:weather][0][:icon]
      }
    end
  end
end
