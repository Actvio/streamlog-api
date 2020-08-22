class ApplicationController < ActionController::API
  before_action :authenticate_request
  before_action :force_json
  before_action :set_cors
  attr_reader :current_user
  # skip_before_action :verify_authenticity_token

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.heade