class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :respond_with_record_not_found

  private

  def respond_with_record_not_found(exception)
    message = I18n.t("errors.not_found", entity: exception.model.underscore.humanize)

    respond_with_error(:not_found, message: message)
  end

  def respond_with_error(code, message: nil)
    render json: { error: { message: message }}, status: code
  end
end