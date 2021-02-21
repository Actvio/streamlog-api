
class Clip < ApplicationRecord
  include ProjectAttachable
  include Commentable
  acts_as_paranoid

  include BelongsToUser
  belongs_to :user, inverse_of: :clips

  belongs_to :audio_file, inverse_of: :clips
  validates :audio_file, :user, presence: :true
  validates :name, :start_time, :end_time, presence: :true
end