Admin.create!(
  email: "a@a",
  password: "aaaaaa"
)

Company.create!(
  id: 1,
  company_name: "テスト株式会社",
  responsible_name: "テスト太郎",
  postcode: 1234567,
  address: "京都府宇治市平等院鳳凰堂1-2-3",
  email: "test@test.com",
  phone_number: "0123456789",
  usage_status: true
)

# Employee.create!(
#   id: 1,
#   company_id: 1,
#   name: Gimei.name.kanji,
#   email: "test@test.com",
#   password: "password",
#   department: "営業部",
#   joining_date: Date.new(2000, 01, 01),
#   admin: true,
#   enrollment_status: true
# )

# 10.times do |n|
#   Employee.create!(
#     id: n + 2,
#     company_id: 1,
#     name: Gimei.name.kanji,
#     email: Faker::Internet.email,
#     password: "password",
#     department: "営業部",
#     joining_date: Date.new(2000, 01, 01),
#     admin: false,
#     enrollment_status: true
#   )
# end
