require 'rails_helper'

RSpec.describe 'Image Info Poros' do
  describe '#initialize' do
    it 'returns an image info object' do
      info = VCR.use_cassette('image_info') do
        BackgroundFacade.get_image('denver')
      end

      expect(info).to be_a(ImageInfo)
      expect(info.id).to eq('NflJmUuaYVI')
      expect(info.image_url).to eq('https://images.unsplash.com/photo-1602800458591-eddda28a498b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNzUyNDB8MHwxfHNlYXJjaHwxfHxkZW52ZXJ8ZW58MHx8fHwxNjM2Nzg0NTU0&ixlib=rb-1.2.1&q=80&w=1080')
      expect(info.profile).to eq('https://api.unsplash.com/users/andrewcoop')
      expect(info.author).to eq('andrewcoop')
      expect(info.location).to eq('denver')

      expect(info).to_not eq(:description)
      expect(info).to_not eq(:current_user_collections)
      expect(info).to_not eq(:categories)
    end
  end
end
