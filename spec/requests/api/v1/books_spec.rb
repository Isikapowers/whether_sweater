require 'rails_helper'

RSpec.describe 'Books API' do
  describe "GET books" do
    it 'returns a list of books' do
      get '/api/v1/book-search?location=denver,co&quantity=5'

      expect(response).to be_successful

      books = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(books).to have_key(:id)
      expect(books[:id]).to eq('null')
      expect(books[:type]).to eq('books')

      expect(books).to have_key(:attributes)
      expect(books[:attributes]).to have_key(:destination)
      expect(books[:attributes][:destination]).to eq('denver,co')
      expect(books[:attributes]).to have_key(:forecast)
      expect(books[:attributes][:forecast]).to have_key(:summary)
      expect(books[:attributes][:forecast]).to have_key(:temperature)

      expect(books[:attributes]).to have_key(:total_books_found)
      expect(books[:attributes]).to have_key(:books)
      expect(books[:attributes][:books].first).to have_key(:isbn)
      expect(books[:attributes][:books].first).to have_key(:title)
      expect(books[:attributes][:books].first).to have_key(:publisher)
    end
  end
end
