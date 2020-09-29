class OtherFilesController < ApplicationController
  skip_before_action :force_json, only: [:new]

  def index
    render json: OtherFile.all
  end

  def show
    render json: OtherFile.find(