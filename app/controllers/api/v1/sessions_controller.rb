class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if !user.nil? && user.authenticate(params[:password])
      render json: UsersSerializer.new(user)
    else
      render json: { error: 'Credentials are invalid.  Please try again.' }, status: :unauthorized
    end
  end
end
