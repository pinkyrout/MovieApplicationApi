class Api::V1::UsersController < Api::V1::BaseController
  require 'securerandom'

  def authenticate_user
    if User.find_by(email: params[:email], password_digest: params[:password])
      secure_token = SecureRandom.hex(10)
      render_success(data: secure_token, message: 'Success', status: :ok)
    else
      render_error(message: 'Login Fail', status: :unauthorized)
    end
  end

  def create
    user = User.new(username: params[:username], email: params[:email], password_digest: params[:password])
    if user.save
    	render_success(message: "Success", status: :ok)
    else
      render_error(message: "Creation Failed", status: :unprocessible_entity)
    end
  end
end
