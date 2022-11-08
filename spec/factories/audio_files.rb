FactoryBot.define do
  factory :audio_file do
    user { FactoryBot.create(:user) }
  end

end
