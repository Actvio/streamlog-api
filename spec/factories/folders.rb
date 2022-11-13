FactoryBot.define do
  factory :folder do
    name { 'Sample Folder'}
    user { FactoryBot.create(:user) }
  end
end
