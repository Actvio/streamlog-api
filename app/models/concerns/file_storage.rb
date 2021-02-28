
module FileStorage
  extend ActiveSupport::Concern

  included do
    include Rails.application.routes.url_helpers
  end

  def calculate_url(storage_obj)
    return nil unless storage_obj.attached?
    return file_storage_host_url(storage_obj) if ENV.fetch('FILE_STORAGE_HOST', nil).present?

    url_for(storage_obj)
  end

  def file_storage_host_url(storage_obj)
    [
      ENV.fetch('FILE_STORAGE_HOST', nil),
      storage_obj.key,
      'blob',
      "#{storage_obj.filename.base}.#{storage_obj.filename.extension}",
    ].join('/')
  end

  def content_type(storage_obj)
    if storage_obj.attached?
      storage_obj.attachment.blob.content_type
    end
  end
end