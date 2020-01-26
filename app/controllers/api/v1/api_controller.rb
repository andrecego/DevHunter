class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :internal_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found(exception)
    render status: :not_found, json: { message: exception }
  end

  def record_invalid(exception)
    render status: :bad_request, json: { message: exception }
  end

  def internal_error
    render status: :internal_server_error, json: { message: 'Server Error'}
  end
end