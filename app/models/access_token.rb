# frozen_string_literal: true

class AccessToken
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def payload
    {
      sub: user.id,
      exp: expiration_time,
      iat: issued_at,
      iss: "token-based-auth",
      aud: "token-based-auth"
    }
  end

  private

  def expiration_time
    issued_at + token_ttl
  end

  def issued_at
    @issued_at ||= Time.current.to_i
  end

  def token_ttl
    Rails.application.credentials.access_token_ttl_sec
  end
end
