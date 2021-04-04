FactoryBot.define do
  factory :admin do
    sequence(:id) { |n| n }
    email { "admin@admin.com" }
    password { "password" }
  end
end
