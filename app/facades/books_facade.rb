class BooksFacade
  def self.get_books(city, quantity)
    data = OpenLibraryService.search_books(city)

    total_books = data[:numFound]

    books = data[:docs].first(quantity.to_i).map do |book_info|
      BookInfo.new(book_info)
    end

    { total_books: total_books, books: books }
  end
end
