# frozen_string_literal: true

class RefreshToken < ApplicationRecord
  COOKIE_NAME = "_token_based_auth_refresh_token".freeze
  EXPIRATION = 3.months

  belongs_to :user

  validates :value, :expires_at, presence: true

  scope :expires_in_future, -> { where("expires_at > ?", Time.current) }
end
