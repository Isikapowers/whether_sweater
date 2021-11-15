class BoredFacade
  def self.get_activity(type)
    data = BoredService.search_random_activity(type)

    BoredInfo.new(data)
  end
end
