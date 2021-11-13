class MapquestService < BaseService
  def self.geocoding(address)
    response = Faraday.get('https://www.mapquestapi.com/geocoding/v1/address') do |req|
      req.params['key'] = ENV['MAPQUEST_KEY']
      req.params['location'] = address
      req.headers['Content-Type'] = 'application/json'
    end
    parse_json(response)
  end

  def self.directions(start_location, end_location)
    response = Faraday.get('https://www.mapquestapi.com/directions/v2/route') do |req|
      req.params['key'] = ENV['MAPQUEST_KEY']
      req.params['from'] = start_location
      req.params['to'] = end_location
      req.headers['Content-Type'] = 'application/json'
    end
    parse_json(response)
  end  
end
