# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

MusicSniperRails::Application.default_url_options = {host: ENV.fetch('RAILS_HOST')}
