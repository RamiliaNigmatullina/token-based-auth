# frozen_string_literal: true

module Users
  class AccessTokenService
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    def access_token
      JwtService.encode(payload:)
    end

    private

    def payload
      AccessToken.new(user).payload
    end
  end
end
