FactoryBot.define do
  factory :employee do
    sequence(:id) { |n| n }
    company_id { Company.first.id }
    name { "テスト次郎" }
    email { "test@test.com" }
    password { "testtest" }
    department { "課長" }
    joining_date { Date.today }
    admin { false }
    enrollment_status { true }
  end
end
