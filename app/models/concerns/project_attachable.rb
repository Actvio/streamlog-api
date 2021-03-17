module ProjectAttachable
  extend ActiveSupport::Concern

  included do
    has_many :project_attachments, as: :item, dependent: :destroy
    has_many :projects, through: :project_attachments, source: :project, source_type: Project.name
  end
end
