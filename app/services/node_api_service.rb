require('rest-client')

class NodeApiService < BaseService
  def initialize(url)
    @url = url
  end

  def trim(start:, duration:)
    full_url = "#{ENV.fetch('NODE_HOST')}/download?url=#{@url}&start=#{start}&duration=#{duration}"
    raw = RestClient::Request.execute(
      method: :get,
      url: full_url,
      raw_response: true)
    f = File.open(raw.file.path)
    audio_file = AudioFile.new(name: 'name.mp3')
    audio_file.attached_file.attach(io: f, filename: 'name.mp3')
    audio_file.save
    audio_file
  end
end
