class Book < ApplicationRecord
  def self.number_of_books(quantity)
    limit(quantity)
  end
end
