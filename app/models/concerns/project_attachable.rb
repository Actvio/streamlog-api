module ProjectAttachable
  extend ActiveSupport::Concern

  included do
    has_many :project_attachments, as: :i