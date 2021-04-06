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

10.times do |n|
  Employee.create!(
    id: n + 1,
    company_id: 1,
    name: Faker::Internet.email
    email
    password
    image_id
    department
    joining_date
    admin
    enrollment_status
  )
end
