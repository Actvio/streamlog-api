FactoryBot.define do
  factory :user do
    username { 's' }
    email { 'some@email.com' }
    password { 'pass' }
    password_confirmation { 'pass' }
  end
end
