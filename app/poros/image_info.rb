class ImageInfo
  attr_reader :id, :info

  def initialize(data, location)
    @id = data[:id]
    @info = get_info(data, location)
  end


  private

  def get_info(data, location)
    {
      "location": location,
      "image_url": data[:urls][:regular],
      "credit": {
        "source": "unsplash.com",
        "author": data[:user][:username],
        "logo": data[:user][:profile_image][:medium]
      }
    }
  end
end
