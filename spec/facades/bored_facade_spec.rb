require 'rails_helper'

RSpec.describe 'Bored Facade' do
  describe "facade" do
    it 'returns activity details' do
      data = VCR.use_cassette('get random activity') do
        BoredFacade.get_activity('relaxation')
      end

      expect(data).to be_a(BoredInfo)

      expect(data.activity).to eq("Go to the library and find an interesting book")
      expect(data.type).to eq('relaxation')
      expect(data.participants).to eq(1)
      expect(data.price).to eq(0.05)

      expect(data.type).to_not eq('cooking')
      expect(data.participants).to_not eq(3)
      expect(data.price).to_not eq(2.50)
    end
  end
end
