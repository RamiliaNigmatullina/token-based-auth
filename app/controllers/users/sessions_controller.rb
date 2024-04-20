class Users::SessionsController < ApplicationController
  before_action :find_user, only: %i[create destroy]

  def create
    if user&.authenticate(user_params[:password])
      render json: UserSerializer.new(user).serialized_json
    else
      respond_with_error(:unauthorized, message: I18n.t("errors.invalid_credentials"))
    end
  end

  def destroy
    head :no_content
  end

  private

  attr_reader :user

  def find_user
    @user ||= User.find_by(email: user_params[:email])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
