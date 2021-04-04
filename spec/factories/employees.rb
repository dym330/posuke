FactoryBot.define do
  factory :employee do
    company_id {1}
    name {"テスト次郎"}
    email {"test@test.com"}
    password {"testtest"}
    department {"課長"}
    joining_date {Date.today}
    admin {false}
    enrollment_status {true}
  end
end
