FactoryBot.define do
  factory :schedule_favorite do
    sequence(:id) { |n| n }
    employee_id { Employee.first.id }
    schedule_id { Schedule.first.id }
  end
end
