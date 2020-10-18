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
      return
    end

    render json: f
  end

  def update
    f = OtherFile.find(params[:id])
    if !f.update(put_params)
      err = error_msg(f)
      render json: {error: err}, status: :bad_request
      return
    end

    render json: f
  end

  def destroy
    f = OtherFile.find(params[:id])
    if !f.destroy
      err = error_msg(f)
      render json: {error: err}, status: :bad_request
      return
    end

    render json: f
  end

  private

  def post_params
    params.require(:other_file).permit(:name, :attached_file)
  end

  def put_params
    params.require(:other_file).permit(:name)
  end
end
