class ApplicationController < ActionController::API
  before_action :authenticate_request
  before_action :force_json
  before_a