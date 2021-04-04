FactoryBot.define do
  factory :group do
    sequence(:id) { |n| n }
    employee_id { Employee.first.id }
    name { "営業部" }
  end
end
