FactoryBot.define do
  factory :schedule do
    sequence(:id) { |n| n }
    employee_id { Employee.first.id }
    title { "資料作成" }
    start_time { DateTime.new(2021, 1, 1) }
    end_time { DateTime.new(2021, 1, 3) }
    content { "あああああ" }
    schedule_status { 0 }
    comment_status { false }
  end
end
