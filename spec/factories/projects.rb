FactoryBot.define do
  factory :project do
    name { 'Project name' }
    user { FactoryBot.create(:user) }
  end

end
