class UnsplashService < BaseService
  def self.search_images(location)
    response = Faraday.get('https://api.unsplash.com/search/photos') do |req|
      req.params['client_id'] = ENV['UNSLASH_KEY']
      req.params['query'] = location.downcase
      req.params['page'] = 1
      req.headers['Content-Type'] = 'application/json'
    end
    parse_json(response)
  end    
end
