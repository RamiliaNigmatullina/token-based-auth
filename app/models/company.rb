# frozen_string_literal: true

class Company < ApplicationRecord
  before_validation :set_subdomain, on: :create

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: { case_sensitive: false }

  private

  def set_subdomain
    self.subdomain = name.downcase.gsub(/\s+/, "-").gsub(/[^\w-]/, "") unless subdomain.present?
  end
end
