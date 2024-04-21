# frozen_string_literal: true

module Users
  class SessionsController < ApplicationController
    def create
      if user&.authenticate(user_params[:password])
        set_access_token
        set_refresh_token

        render json: UserSerializer.new(user).serialized_json, status: :created
      else
        respond_with_error(:unauthorized, message: I18n.t("errors.invalid_credentials"))
      end
    end

    def destroy
      head :no_content
    end

    private

    def set_access_token
      response.set_header("Authorization", "Bearer #{access_token}")
    end

    def set_refresh_token
      cookies.encrypted[RefreshToken::COOKIE_NAME] = RefreshTokenService.new(user:).refresh_token_cookie
    end

    def access_token
      AccessTokenService.new(user:).access_token
    end

    def user
      @user ||= User.find_by(email: user_params[:email])
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
