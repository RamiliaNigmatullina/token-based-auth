# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordNotFound, with: :respond_with_record_not_found
  rescue_from RefreshTokenCreationError, with: :respond_with_unprocessable_entity

  private

  def respond_with_record_not_found(exception)
    message = I18n.t("errors.not_found", entity: exception.model.underscore.humanize)

    respond_with_error(:not_found, message:)
  end

  def respond_with_unprocessable_entity(exception)
    respond_with_error(:unprocessable_entity, message: exception.message)
  end

  def respond_with_unauthorized(message = nil)
    message ||= I18n.t("errors.unauthorized")

    respond_with_error(:unauthorized, message: message)
  end

  def respond_with_error(code, message: nil)
    render json: { error: { message: } }, status: code
  end
end
