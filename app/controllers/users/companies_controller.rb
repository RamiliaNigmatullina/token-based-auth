# frozen_string_literal: true

module Users
  class CompaniesController < BaseController
    def index
      render json: CompanySerializer.new(companies).serializable_hash.to_json
    end

    private

    def companies
      @companies ||= Company.all
    end
  end
end
