
class OmniauthSessionsController < ApplicationController
  skip_before_action :authenticate_request
  skip_before_action :force_json

  def create