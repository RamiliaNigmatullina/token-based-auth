class Users::SessionsController < ApplicationController
  before_action :find_user, only: :create

  def create
    if user&.authenticate(user_params[:password])
      response.set_header("Authorization", "Bearer #{jwt_token}")

      render json: UserSerializer.new(@user).serialized_json, status: :created
    else
      respond_with_error(:unauthorized, message: I18n.t("errors.invalid_credentials"))
    end
  end

  def destroy
    head :no_content
  end

  private

  attr_reader :user

  def jwt_token
    JwtService.encode(payload: payload)
  end

  def payload
    AccessToken.new(user).payload
  end

  def find_user
    @user ||= User.find_by(email: user_params[:email])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
