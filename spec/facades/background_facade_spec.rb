require 'rails_helper'

RSpec.describe 'Background Facade' do
  it 'returns an image data', :vcr do
    response = BackgroundFacade.get_image('denver')

    expect(response).to be_a(ImageInfo)
    expect(response.location).to eq('denver')
    expect(response.image_url).to eq('https://images.unsplash.com/photo-1602800458591-eddda28a498b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNzUyNDB8MHwxfHNlYXJjaHwxfHxkZW52ZXJ8ZW58MHx8fHwxNjM2Nzg0NTU0&ixlib=rb-1.2.1&q=80&w=1080')
    expect(response.author).to eq('andrewcoop')
    expect(response.id).to eq('NflJmUuaYVI')
    expect(response.profile).to eq('https://api.unsplash.com/users/andrewcoop')
  end

  it 'returns an error when no image found' do
    response = BackgroundFacade.get_image('denver.com')

    expect(response).to eq('Location Invalid')
  end
end
