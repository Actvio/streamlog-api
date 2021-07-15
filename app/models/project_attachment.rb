class ProjectAttachment < ApplicationRecord
  acts_as_paranoid

  belongs_to :project, inverse_of: :project_attachments
  belongs_to :item, polymorphic: true, inverse_of: :project_attachments
end
