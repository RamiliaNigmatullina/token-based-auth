# frozen_string_literal: true

module Users
  class MesController < BaseController
    def show
      render json: UserSerializer.new(current_user).serialized_json
    end
  end
end
