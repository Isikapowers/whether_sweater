class BooksSerializer
  # include JSONAPI::Serializer
  #
  # attributes :destination, :forecast, :total_books_found, :books
  #
  def self.format_data(books, weather, location)
    {
      "data": {
        "id": "null",
        "type": 'books',
        "attributes": {
          "destination": "#{location}",
          "forecast": {
            "summary": "#{weather.current_weather[:condition]}",
            "temperature": "#{weather.current_weather[:temperature]} F"
          },
          "total_books_found": books[:total_books],
          "books": all_books(books)
        }
      }
    }
  end

  def self.all_books(books)
    books[:books].each do |book|
      {
        "isbn": book.isbn,
        "title": book.title,
        "publisher": book.publisher
      }
    end
  end
end
