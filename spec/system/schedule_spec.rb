require 'rails_helper'

RSpec.describe "スケジュール関係のテスト", type: :system do
  context "admin権限の無い従業員" do
    before do
      create(:company)
      create(:employee, admin: false)
      visit login_path
      fill_in "session_email", with: Employee.first.email
      fill_in "session_password", with: "testtest"
      click_button "ログイン"
    end

    it "スケジュールの新規投稿" do
      expect(page).not_to have_content("書類作成")
      click_link "予定作成"
      fill_in "schedule_title", with: "書類作成"
      fill_in "schedule_start_time", with: Time.zone.local(2020, 1, 1, 10, 0, 0)
      fill_in "schedule_end_time", with: Time.zone.local(2020, 1, 1, 12, 0, 0)
      fill_in "schedule_content", with: "頑張ります！"
      click_button "投稿"
      expect(page).to have_content("20年01月01日 10:00 〜 12:00")
      expect(page).to have_content("書類作成")
      expect(page).to have_content("頑張ります！")
    end

    it "スケジュールの編集" do
      schedule = create(:schedule)
      visit schedules_path
      click_link "schedule-post-#{schedule.id}"
      find(".fa-edit").click
      fill_in "schedule_title", with: "A社商談"
      fill_in "schedule_start_time", with: Time.zone.local(2020, 1, 1, 13, 0, 0)
      fill_in "schedule_end_time", with: Time.zone.local(2020, 1, 2, 15, 0, 0)
      fill_in "schedule_content", with: "決めてきます！"
      click_button "投稿"
      expect(page).to have_content("20年01月01日 13:00 〜 20年01月02日 15:00")
      expect(page).to have_content("A社商談")
      expect(page).to have_content("決めてきます！")
    end

    it "スケジュールの削除", js: true do
      schedule = create(:schedule)
      visit schedules_path
      expect(page).to have_content("資料作成")
      visit schedule_path(schedule)
      page.accept_confirm do
        find(".fa-trash-alt").click
      end
      expect(page).to have_content("予定を削除しました")
      expect(page).not_to have_content("資料作成")
    end

    it "スケジュールの質問追加" do
      schedule = create(:schedule)
      visit schedule_path(schedule)
      expect(page).not_to have_content("質問中")
      visit edit_schedule_path(schedule)
      fill_in "schedule_question", with: "○○についてわからないため教えていただけないでしょうか？"
      click_button "投稿"
      expect(page).to have_content("質問中")
      expect(page).to have_content("○○についてわからないため教えていただけないでしょうか？")
    end

    it "質問状況の変更" do
      schedule = create(:schedule, question: "質問内容", schedule_status: 1)
      visit schedule_path(schedule)
      expect(page).to have_selector '.badge-danger', text: "1"
      find(".fa-question").click
      expect(page).not_to have_selector '.badge-danger'
      expect(page).to have_content("解決済質問")
      find(".fa-lightbulb").click
      expect(page).to have_selector '.badge-danger', text: "1"
      expect(page).to have_content("質問中")
    end

    it "投稿が自身ではない物への編集、削除制限" do
      create(:employee)
      other_employee_schedule = create(:schedule, employee_id: Employee.last.id)
      visit schedule_path(other_employee_schedule)
      expect(page).not_to have_selector '.fa-edit'
      expect(page).not_to have_selector '.fa-trash-alt'
      visit edit_schedule_path(other_employee_schedule)
      expect(current_path).to eq(schedules_path)
    end
  end

  context "admin権限の従業員" do
    before do
      create(:company)
      create(:employee, admin: true)
      visit login_path
      fill_in "session_email", with: Employee.first.email
      fill_in "session_password", with: "testtest"
      click_button "ログイン"
    end

    it "投稿が自身ではないスケジュールでも編集、削除可能" do
      create(:employee)
      other_employee_schedule = create(:schedule, employee_id: Employee.last.id)
      visit schedule_path(other_employee_schedule)
      expect(page).to have_selector '.fa-edit'
      expect(page).to have_selector '.fa-trash-alt'
      visit edit_schedule_path(other_employee_schedule)
      expect(current_path).to eq(edit_schedule_path(other_employee_schedule))
    end
  end
end