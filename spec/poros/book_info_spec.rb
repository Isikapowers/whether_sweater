require 'rails_helper'

RSpec.describe 'Book Info Poros' do
  it 'returns book objects', :vcr do
    books = VCR.use_cassette('get_books_by_destination') do
      BooksFacade.get_books('denver,co', 5)
    end

    expect(books[:books].first).to be_a(BookInfo)
    expect(books[:total_books]).to be_a(Integer)
    expect(books[:total_books]).to eq(41672)

    expect(books[:books].first.isbn).to eq(["9780762507849", "0762507845"])
    expect(books[:books].first.title).to eq("Denver, Co")
    expect(books[:books].first.publisher).to eq(["Universal Map Enterprises"])

    expect(books).to_not have_key(:language)
    expect(books).to_not have_key(:author_key)
    expect(books).to_not have_key(:author_name)
  end
end
