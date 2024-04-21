# frozen_string_literal: true

class RefreshTokenCreationError < StandardError
  def initialize
    super("Failed to create a refresh token")
  end
end
