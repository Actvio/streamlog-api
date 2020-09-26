
class FoldersController < ApplicationController
  def index
    folders = Folder.includes(:folder_items).all
    render json: folders, include: :folder_items
  end

  def show
    folder = Folder.includes(:folder_items).find_by(id: params[:id])
    render json: folder, include: [:folder_items, :items]
  end

  def create
    folder = current_user.folders.new(folder_params)
    if !folder.save
      err = folder.errors.full_messages.join('. ')
      render json: {error: err}, status: :bad_request
      return
    end

    render json: folder
  end

  def update
    folder = Folder.find_by(id: params[:id])
    if folder.blank?
      render json: {error: 'Folder does not exist'}, status: :bad_request
      return
    end

    if !folder.update(folder_params)
      err = folder.errors.full_messages.join('. ')
      render json: {error: err}, status: :bad_request
      return
    end

    render json: folder, include: [:folder_items, :items]
  end

  def folder_params
    params.require(:folder).permit(
      :name,
      folder_items_attributes: [:id, :item_type, :item_id, :folder_id, :_destroy],
    )
  end
end