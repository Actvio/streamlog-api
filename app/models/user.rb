require 'open-uri'

class User < ApplicationRecord
  include FileStorage
  has_secure_password validations: false
  has_one_attached :avatar
  acts_as_paranoid

  has_many :comments, 