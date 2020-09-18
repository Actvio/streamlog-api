class ClipsController < ApplicationController
  def create
    p = clip_params
    if p[:audio_file_id].blank?
      render json: {error: 'No audio file id'}, status: 400
      return
    end

    c = current_user.clips.new(p)
    if c.save
      render json: c
    else
      err = c.errors.full_messages.join('. ')
      render