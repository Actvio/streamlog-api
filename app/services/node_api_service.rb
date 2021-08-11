require('rest-client')

class NodeApiService < BaseService
  def initialize(url)
    @url = url
  end

  def trim(start:, duration:)
    full_url = "#{ENV.fetch('NODE_HOST')}/download?url=#{@url}&start=#{start}&duration=#{duration}"
    raw = 