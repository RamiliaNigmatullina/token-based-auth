module Users
  class RefreshTokenService
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    def refresh_token_cookie
      {
        value: refresh_token.value,
        httponly: true,
        secure: Rails.env.production?,
        samesite: :strict,
        expires: refresh_token.expires_at
      }
    end

    private

    def refresh_token
      @refresh_token ||= RefreshToken.create(
        user: user,
        expires_at: RefreshToken::EXPIRATION.from_now,
        value: SecureRandom.uuid
      )
    end
  end
end
