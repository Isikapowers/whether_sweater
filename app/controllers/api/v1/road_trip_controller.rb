class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: road_trip_params[:api_key])
    if user
      trip = RoadTripFacade.road_trip_info(road_trip_params[:origin], road_trip_params[:destination])
      render json: RoadtripSerializer.new(trip), status: :ok
    else
      render json: { error: 'Invalid API key' }, status: :unauthorized
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end

  # def find
  #   user = User.find_by(api_key: road_trip_params[:api_key])
  #   if params[:origin].present? && params[:destination].present?
  #     trip = search_trip(params[:origin], params[:destination])
  #     render json: RoadtripSerializer.new(trip), status: :ok
  #   else
  #     render json: { error: 'no valid email given' }, status: :not_found
  #   end
  # end
end
