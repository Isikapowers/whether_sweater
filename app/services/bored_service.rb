class BoredService < BaseService
  def self.search_random_activity(type)
    response = Faraday.get("http://www.boredapi.com/api/activity?type=#{type}")

    parse_json(response)
  end
end
