class Api::V1::ActivitiesController < ApplicationController
  def index
    if params[:destination].present?
      forecast = ForecastFacade.get_forecast(params[:destination])
      relax = BoredFacade.get_activity('relaxation')

      if forecast.current_weather[:temperature] >= 60
        activity = BoredFacade.get_activity('recreational')
      elsif forecast.current_weather[:temperature] >= 50 && forecast.current_weather[:temperature] < 60
        activity = BoredFacade.get_activity('busywork')
      else
        activity = BoredFacade.get_activity('cooking')
      end

      activities = [relax, activity]

      render json: ActivitiesSerializer.format_data(activities, forecast, params[:destination]), status: :ok
    else
      render json: { error: 'no valid params given' }, status: :bad_request
    end
  end
end
