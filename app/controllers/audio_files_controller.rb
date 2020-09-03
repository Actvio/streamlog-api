
class AudioFilesController < ApplicationController
  skip_before_action :force_json, only: [:new]

  def create
    @audio_file = current_user.audio_files.new(post_params)
    if !@audio_file.save
      err = @audio_file.errors.full_messages.join('. ')
      render json: {error: err}, status: :bad_request
      return
    end
    render json: render_audio_file(@audio_file)
  end

  def index
    @audio_files = AudioFile.includes(:clips).all
    render json: @audio_files.map {|f| render_audio_file(f)}
  end

  def show
    @audio_file = AudioFile.find(params[:id])
    render json: render_audio_file(@audio_file)
  end

  def new
    @audio_file = AudioFile.new
  end

  def trim
    @audio_file = AudioFile.find(params[:id])
    api = NodeApiService.new(@audio_file.url)
    @audio_file = api.trim(start: params[:start], duration: params[:duration])
    render json: render_audio_file(@audio_file)
  end

  private

  def post_params
    params.require(:audio_file).permit(:name, :attached_file, :audio_length)
  end

  def render_audio_file(f)
    name =  f.attached_file.filename if f.attached_file.attached?
    f.as_json.merge(
      file_name: name,
      clip_ids: f.clips.pluck(:id),
      url: f.url,
    )
  end
end