# frozen_string_literal: true

module Users
  class SessionsController < ApplicationController
    before_action :find_user, only: :create

    def create
      if user&.authenticate(user_params[:password])
        response.set_header("Authorization", "Bearer #{access_token}")

        cookies.encrypted[RefreshToken::COOKIE_NAME] = refresh_token_cookie

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

    def access_token
      Users::AccessTokenService.new(user:).access_token
    end

    def refresh_token_cookie
      Users::RefreshTokenService.new(user:).refresh_token_cookie
    end

    def find_user
      @user ||= User.find_by(email: user_params[:email])
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
