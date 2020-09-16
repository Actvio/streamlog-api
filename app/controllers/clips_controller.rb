class ClipsController < ApplicationController
  def create
    p = clip_params
    if p[:audio_file_id].blank?
      render json: {error: 'No audio file id'}, status: 400
    