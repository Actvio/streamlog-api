class Project < ApplicationRecord
  include BelongsToUser
  belongs_to :user, inverse_of: :projects
  acts_as_paranoid

  has_many :project_attachments, inverse_of: :project, dependent: :destroy
  accepts_nested_attributes_for :project_attachments, allow_destroy: true

  has_many :comments, as: :commentable
  has_many :audio_files, through: :project_attachments, source: :item, source_type: Audi