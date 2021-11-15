class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].present?
      forecast = ForecastFacade.get_forecast(params[:location])

      render json: ForecastSerializer.new(forecast), status: :ok
    else
      render json: { error: 'valid params not given' }, status: :bad_request
    end
  end
end
