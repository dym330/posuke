FactoryBot.define do
  factory :schedule do
    sequence(:id) { |n| n }
    employee_id { Employee.first.id }
    title { "資料作成" }
    start_time { Date.today }
    end_time { Date.tomorrow }
    content { "あああああ" }
    schedule_status { 0 }
    comment_status { false }
  end
end
