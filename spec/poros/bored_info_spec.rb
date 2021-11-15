require 'rails_helper'

RSpec.describe 'Bored Info Poros' do
  describe "poros" do
    it 'returns activity objects' do
      data = VCR.use_cassette('get random activity') do
        BoredFacade.get_activity('relaxation')
      end

      expect(data).to be_a(BoredInfo)

      expect(data.activity).to eq("Go to the library and find an interesting book")
      expect(data.type).to eq('relaxation')
      expect(data.participants).to eq(1)
      expect(data.price).to eq(0.05)
    end
  end
end
