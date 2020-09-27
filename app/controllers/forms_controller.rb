class FormsController < ActionController::Base

  def audio_files
    @audio_file = AudioFile.new
    render 'forms/audio_files/ne