# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validation' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe '#search_by_email(email)' do
    it 'can search user by email' do
      user = User.create({ email: 'lucy@gmail.com',
                           password: 'password',
                           password_confirmation: 'password'
                          })

      expect(User.search_by_email('lucy@gmail.com')).to eq([user])
    end
  end
end
