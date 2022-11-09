FactoryBot.define do
  factory :clip do
    audio_file { FactoryBot.create(:audio_file) }
    user { FactoryBot.create(:user) }
    name { 'Example Clip' }
    start_time { 0 }
    end_time { 100 }
  end

end
