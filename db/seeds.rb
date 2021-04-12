Admin.create!(
  email: "admin@admin.com",
  password: "password"
)

3.times do |n|
  Company.create!(
    id: n + 1,
    company_name: "テスト株式会社#{ n + 1 }",
    responsible_name: Gimei.name.kanji,
    postcode: 1234567,
    address: Gimei.address.kanji,
    email: "test#{ n + 1 }@test.com",
    phone_number: "0123456789",
    usage_status: true
  )
end

3.times do |i|
  Employee.create!(
    id: i * 6 + 1,
    company_id: i + 1,
    name: Gimei.name.kanji,
    email: "test#{ i + 1 }-1@test.com",
    password: "password",
    image: open("#{ Rails.root }/db/fixtures/employee_image_1.png"),
    department: "営業部",
    joining_date: Date.new(2000, 01, 01),
    admin: true,
    enrollment_status: true
  )

  5.times do |j|
    Employee.create!(
      id: i * 6 + j + 2,
      company_id: i + 1,
      name: Gimei.name.kanji,
      email: "test#{ i + 1 }-#{ j + 2 }@test.com",
      image: open("#{ Rails.root }/db/fixtures/employee_image_#{ j + 2 }.png"),
      password: "password",
      department: "営業部",
      joining_date: Date.new(2000, 01, 01),
      admin: false,
      enrollment_status: true
    )

    initial_day = DateTime.now.beginning_of_day + 8.hour
    Schedule.create!(
      id: i * 15 + j * 3 + 1,
      employee_id: i * 6 + j + 2,
      title: "A社書類作成",
      start_time: initial_day,
      end_time: initial_day + 4.hour,
      content: "おはようございます\r\n今日も1日頑張ります！",
      question: "○○について分からないのですが、教えていただけないでしょうか？",
      schedule_status: 2,
      comment_status: true
    )
    Schedule.create!(
      id: i * 15 + j * 3 + 2,
      employee_id: i * 6 + j + 2,
      title: "B社書類作成",
      start_time: initial_day + 5.hour,
      end_time: initial_day + 8.hour,
      content: "おはようございます\r\n今日も1日頑張ります！",
      question: "○○について分からないのですが、教えていただけないでしょうか？",
      schedule_status: 1,
      comment_status: false
    )
    Schedule.create!(
      id: i * 15 + j * 3 + 3,
      employee_id: i * 6 + j + 2,
      title: "C社書類作成",
      start_time: initial_day + 8.hour,
      end_time: initial_day + 10.hour,
      content: "おはようございます\r\n今日も1日頑張ります！"
    )

    2.times do |k|
      ScheduleComment.create!(
        id: i * 10 + j * 2 + k + 1,
        employee_id: i * 6 + 1,
        schedule_id: i * 15 + j * 3 + k + 1,
        comment: "▲▲をすれば良いですよ！"
      )
    end
  end
end


