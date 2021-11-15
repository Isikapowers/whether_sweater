class ActivitiesSerializer
  def self.format_data(activities, weather, destination)
    {
      "data": {
        "id": "null",
        "type": "activities",
        "attributes": {
          "destination": "#{destination}",
          "forecast": {
            "summary": "#{weather.current_weather[:conditions]}",
            "temperature": "#{weather.current_weather[:temperature]} F"
          },
          "activities": [
          {
            "title": activities.first.activity,
            "type": activities.first.type,
            "participants": activities.first.participants,
            "price": activities.first.price
          },
          {
            "title": activities.second.activity,
            "type": activities.second.type,
            "participants": activities.second.participants,
            "price": activities.second.price
          }
          ]
        }
      }
    }
  end
end
