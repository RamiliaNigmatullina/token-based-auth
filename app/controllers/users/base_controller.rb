module Users
  class BaseController < ApplicationController
    before_action :authenticate_user!

    attr_reader :current_user

    private

    def authenticate_user!
      payload = JwtService.decode(token:)
      
      @current_user = User.find(payload["sub"])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      respond_with_unauthorized
    end

    def token
      auth_header = request.headers["Authorization"]
      auth_header.split.last if auth_header&.start_with?("Bearer ")
    end
  end
end
