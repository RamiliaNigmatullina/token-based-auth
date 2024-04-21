# frozen_string_literal: true

class RefreshToken < ApplicationRecord
  COOKIE_NAME = "_token_based_auth_refresh_token"
  EXPIRATION = Rails.application.credentials.refresh_token_ttl_months.months

  belongs_to :user

  validates :value, :expires_at, presence: true

  scope :expires_in_future, -> { where("expires_at > ?", Time.current) }
end
