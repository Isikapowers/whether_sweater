class MapquestFacade
  def self.get_coordinates(location)
    result = MapquestService.geocoding(location)[:results]

    result.first[:locations].first[:latLng]
  end
end
