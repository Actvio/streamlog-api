class Project < ApplicationRecord
  include BelongsToUser
  belongs_to :user, inverse_of: :projects
  acts_as_paranoid

  has_many :project