class ProjectsController < ApplicationController
  def index
    render json: Project.all, include: [:project_attachments, :clips]
  end

  def create
    @project = current_user.projects.create(project_params)

    render json: @project, include: [:project_attachments, :clips]
  end

  def update
    @project = Project.find(params[:id])
    if !@project.update(project_params)
      render json: {error: 'Failed to update project'}, status: :bad_request
    end

    render json: @project, include: [:project_attachments, :clips]
  end

  def clips
    @project = Project.find(params[:id])
    render json: @project.clips
  end

  def add_clip
    @project = Project.find(params[:id])

    if @project.clips.where(id: params[:clip_id]).length > 0
      render json: {error: 'Clip already attached to project'}, status: :bad_request
    end

    clip = Clip.find(params[:clip_id])
    @project.clips.push(clip)
    if !@project.save
      render json: {error: 'Failed to update project'}, status: :bad_request
    end

    render json: @project, include: [:project_attachments]
  end

  def remove_clip
    @project = current_user.projects.find(params[:id])

    if @project.clips.where(id: params[:clip_id]).length == 0
      render json: {error: 'Clip not attached to project'}, status: :bad_request
    end

    join_obj = @project.project_attachments.find_by(item_type: Clip.name, item_id: params[:clip_id])
    if !@project.project_attachments.delete(join_obj.id)
      render json: {error: 'Failed to update project'}, status: :bad_request
    end

    render json: @project, include: [:project_attachments]
  end

  private

  def project_params
    params.require(:project).permit(
      :name,
      project_attachments_attributes: [:id, :item_type, :item_id, :project_id, :_destroy],
    )
  end
end
