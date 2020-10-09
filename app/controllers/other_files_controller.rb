class OtherFilesController < ApplicationController
  skip_before_action :force_json, only: [:new]

  def index
    render json: OtherFile.all
  end

  def show
    render json: OtherFile.find(params[:id])
  end

  def create
    f = current_user.other_files.new(post_params)
    if !f.save
      err = error_msg(f)
      render json: {error: err}, status: :bad_request
 