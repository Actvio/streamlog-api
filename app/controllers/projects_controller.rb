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
    if !@project.update(project_