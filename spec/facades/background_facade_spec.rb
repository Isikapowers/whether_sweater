require 'rails_helper'

RSpec.describe 'Background Facade' do
  it 'returns an image data' do
    response = BackgroundFacade.get_image('denver')

    expect(response).to be_a(ImageInfo)
    expect(response.info).to have_key(:location)
    expect(response.info).to have_key(:image_url)
    expect(response.info).to have_key(:credit)
    expect(response.info[:credit]).to have_key(:source)
    expect(response.info[:credit]).to have_key(:author)
    expect(response.info[:credit]).to have_key(:logo)
  end

  xit 'returns an error when no image found' do
    response = BackgroundFacade.get_image('denver.co')

    expect(response[:error]).to eq('Location Invalid')
  end
end
