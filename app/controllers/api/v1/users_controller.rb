class Api::V1::UsersController < Api::V1::BaseController
  def authenticate_user
    if User.find_by(email: params[:email], password_digest: params[:password])
      render_success(message: 'Success', status: :ok)
    else
      render_error(message: 'Login Fail', status: :unauthorized)
    end
  end
end
