require 'open-uri'

class User < ApplicationRecord
  include FileStorage
  has_secure_password validations: false
  has_one_attached :avatar
  acts_as_paranoid

  has_many :comments, inverse_of: :user
  has_many :projects, inverse_of: :user
  has_many :clips, inverse_of: :user
  has_many :audio_files, inverse_of: :user
  has_many :other_files, inverse_of: :user
  has_many :notifications, inverse_of: :user
  has_many :folders, inverse_of: :user
  has_many :oauth_access_datas

  # validates :email, uniqueness: true, presence: true

  def image_url
    calculate_url(avatar)
  end

  def as_json(options={})
    super(options.merge(except: ['password_digest'], methods: [:image_url]))
  end

  def send_email(message)
    puts "Emailing #{username} notifications: \n#{message}"
  end

  def send_push_notification(message)
    # queue for later
    puts "Sending push notification to #{username}: \n#{message}"
  end

  def self.create_with_google_info(payload)
    email = payload['email']

    user = User.create!(
      email: email,
      password: 'google',
      username: email.slice(0, email.index('@')),
      first_name: payload['name'],
      last_name: payload['given_name'],
    )

    avatar_url = payload['picture']
    if avatar_url.present?
      avatar = open(avatar_url)
      user.avatar.attach(io: avatar, filename: 'avatar.jpg')
    end

    user
  end

  def self.subscribed_to_notification_type(type)
    if Notification::GROUP_TYPE_COMMENTS.include? type
      # lets filter on users that want comment notifications
      # return joins(:notification_settings).where(comments: true)
    end

    return where.not(id: 0)
  end
end
