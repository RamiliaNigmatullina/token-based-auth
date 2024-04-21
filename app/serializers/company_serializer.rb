# frozen_string_literal: true

class CompanySerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :subdomain
end
