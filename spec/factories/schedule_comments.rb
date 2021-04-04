FactoryBot.define do
  factory :schedule_comment do
    sequence(:id) { |n| n }
    employee_id { Employee.first.id }
    schedule_id { Schedule.first.id }
    comment { "頑張れ！" }
  end
end
