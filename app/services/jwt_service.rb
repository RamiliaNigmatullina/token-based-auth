# frozen_string_literal: true

class JwtService
  HMAC_SECRET = Rails.application.credentials.secret_key_base
  ALGORITHM = "HS256"

  def self.encode(payload:)
    JWT.encode(payload, HMAC_SECRET, ALGORITHM)
  end

  def self.decode(token:)
    body = JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHM }).first

    ActiveSupport::HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError
    nil
  end
end
