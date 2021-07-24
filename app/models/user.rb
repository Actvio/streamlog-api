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

  # validates :email, uniqueness