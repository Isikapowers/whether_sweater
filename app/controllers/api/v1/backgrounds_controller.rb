class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location].present?
      image = BackgroundFacade.get_image(params[:location])
      render json: ImageSerializer.format_data(image), status: :ok
    else
      render json: { error: 'cannot find background image' }, status: :bad_request
    end
  end
end
