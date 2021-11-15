require 'rails_helper'

RSpec.describe 'Books Facade' do
  it 'returns book info' do
    books = VCR.use_cassette('get books by destination') do
      BooksFacade.get_books('denver,co', 5)
    end

    expect(books).to be_a(Hash)
    expect(books[:books].first).to be_a(BookInfo)
    expect(books[:total_books]).to be_a(Integer)
    expect(books[:total_books]).to eq(41672)

    expect(books[:books].first.isbn).to eq(["9780762507849", "0762507845"])
    expect(books[:books].first.title).to eq("Denver, Co")
    expect(books[:books].first.publisher).to eq(["Universal Map Enterprises"])

    expect(books[:books].first).to_not eq(:language)
    expect(books[:books].first).to_not eq(:author_key)
    expect(books[:books].first).to_not eq(:author_name)
  end
end
