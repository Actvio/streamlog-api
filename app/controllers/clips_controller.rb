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
      render json: {error: err}, status: 400
    end
  end

  def index
    if params[:audio_file_id]
      f = AudioFile.find_by(id: params[:audio_file_id])
      clips = f.clips
    elsif params[:project_id]
      p = Project.find_by(id: params[:audio_file_id])
      clips = p.clips
    else
      clips = Clip.all
    end
    render json: clips
  end

  def clip_params
    params.require(:clip).permit(:audio_file_id, :name, :start_time, :end_time)
  end
end
