class BookInfo
  attr_reader :isbn, :title, :publisher

  def initialize(data)
    @total = data[:total_books]
    @isbn = data[:isbn]
    @title = data[:title]
    @publisher = data[:publisher]
    # @location = location
  end
end
