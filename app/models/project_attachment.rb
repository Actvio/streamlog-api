class ProjectAttachment < ApplicationRecord
  acts_as_paranoid

  belongs_to :project, inverse_of: :proj