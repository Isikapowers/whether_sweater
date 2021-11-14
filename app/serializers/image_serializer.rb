class ImageSerializer
  def self.format_data(image)
    {
      "data": {
        "id": image.id,
        "type": 'image',
        "attributes": {
          "image": {
            "location": image.location,
            "image_url": image.image_url,
            "credit": {
              "source": 'unsplash.com',
              "author": image.author,
              "profile": image.profile
            }
          }
        }
      }
    }
  end
end
