class ClipsController < ApplicationController
  def create
    p = clip_params
    if p[:audio_file