class ImageInfo
  attr_reader :id, :location, :image_url, :author, :profile

  def initialize(data, location)
    @id = data[:id]
    @location = location
    @image_url = data[:urls][:regular]
    @author = data[:user][:username]
    @profile = data[:user][:links][:self]
  end
end
