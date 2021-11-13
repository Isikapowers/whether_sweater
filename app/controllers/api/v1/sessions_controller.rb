class Api::V1::SessionsController < ApplicationController
  def create
    session = User.new(session_params)
    if session.save
      session.update(api_key: SecureRandom.hex(20))
      render json: UsersSerializer.new(session), status: :created
    else
      render json: { error: "Credentials are invalid.  Please try again." }, status: :bad_request
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
