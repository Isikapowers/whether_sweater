class OpenLibraryService < BaseService
  def self.search_books(city)
    response = Faraday.get("http://openlibrary.org/search.json") do |req|
      req.params[:q] = city
      # req.params[:quantity] = quantity
    end
    parse_json(response)
  end
end
