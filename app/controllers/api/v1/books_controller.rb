class Api::V1::BooksController < ApplicationController
  def index
    if params[:location].present? && params[:quantity].present?
      if params[:quantity].to_i > 0
        # coordinates = MapquestFacade.get_coordinates(params[:location])

        weather = ForecastFacade.get_forecast(params[:location])
        books = BooksFacade.get_books(params[:location], params[:quantity])

        render json: BooksSerializer.format_data(books, weather, params[:location]), status: :ok
      else
        render json: { error: 'quantity needs to be greater than 0' }, status: :bad_request
      end
    else
      render json: { error: 'no books found' }, status: :bad_request
    end
  end
end
