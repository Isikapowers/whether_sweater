class ImageSerializer
  # include JSONAPI::Serializer
  #
  # set_type :image
  #
  # attributes :info

  def self.format_data(image)
    {
      "data": {
        "id": image.id,
        "type": 'image',
        "attributes": {
          "image": {
            "location": image.info[:location],
            "image_url": image.info[:image_url],
            "credit": {
              "source": image.info[:source],
              "author": image.info[:author],
              "logo": image.info[:logo]
            }
          }
        }
      }
    }
  end
end
