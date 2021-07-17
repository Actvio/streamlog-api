require 'open-uri'

class User < ApplicationRecord
  include FileStorage
  has_secure_password validatio