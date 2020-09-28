class OtherFilesController < ApplicationController
  skip_before_action :force_json, only: [:new]

  def index
   