FactoryBot.define do
  factory :clip do
    audio_file { FactoryBot.create(:audio_file) }
    user { FactoryBot.create(:user) }
    na