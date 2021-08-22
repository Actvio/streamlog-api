json.(@audio_file, :id, :url)
json.file_name @audio_file.attached_file.filename if @audio_file.attached_file.attached?
json.clip_ids @audio_file.clips.pluck(:id)
