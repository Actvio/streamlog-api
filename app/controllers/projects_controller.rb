class ProjectsController < ApplicationController
  def index
    render json: Project.all, include: [:project_attachm