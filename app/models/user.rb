# frozen_string_literal: true

class User < ApplicationRecord
  before_save :encrypt_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true, if: :password_required?

  def authenticate(password)
    BCrypt::Password.new(self.password) == password
  end

  private

  def password_required?
    new_record? || password.present?
  end

  def encrypt_password
    self.password = BCrypt::Password.create(password) if password.present?
  end
end
