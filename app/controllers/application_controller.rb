class ApplicationController < ActionController::API
  before_action :authenticate_request
  before_action :force_json
  before_action :set_cors
  attr_reader :current_user
  # skip_before_action :verify_authenticity_token

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def force_json
     request.format = :json
  end

  def set_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def error_msg(other_file)
    if other_file.errors.present?
      other_file.errors.full_messages.join('. ')
    end

    return ''
  end

  protected def unauthorized(errors:)
    render json: { error: errors }, status: :unauthorized
  end
end
