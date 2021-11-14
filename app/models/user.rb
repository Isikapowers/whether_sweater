class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :api_key, uniqueness: true
  
  has_secure_password

  before_create do
    self.api_key = SecureRandom.hex(20)
  end
end
