FactoryBot.define do
  factory :group_relationship do
    sequence(:id) { |n| n }
    employee_id { Employee.first.id }
    group_id { Group.first.id }
  end
end
