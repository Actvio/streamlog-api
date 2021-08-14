
json.array! @audio_files do |file|
  json.(file, :id, :url)
  json.file_name file.attached_file.filename if file.attached_file.attached?
  json.clip_ids file.clips.pluck(:id)
end