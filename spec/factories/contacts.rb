FactoryBot.define do
  factory :contact do
    sequence(:id) { |n| n }
    company_name { "株式会社テスト" }
    responsible_name { "テスト三郎" }
    email { "test@test.com" }
    message { "検討しております" }
  end
end
