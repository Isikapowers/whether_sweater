class BackgroundFacade
  def self.get_image(location)
    result = UnsplashService.search_images(location)[:results].first

    return 'Location Invalid' if result.nil?

    ImageInfo.new(result, location)
  end
end
