require 'rails_helper'

RSpec.describe 'Open Library API' do
  describe "#initialize" do
    it 'can connect to open library api' do

      books = OpenLibraryService.search_books('denver')

      expect(books).to have_key(:numFound)
      expect(books[:docs].first).to be_a(Hash)
      expect(books[:docs].first).to have_key(:isbn)
      expect(books[:docs].first).to have_key(:title)
      expect(books[:docs].first).to have_key(:publisher)
    end
  end
end
