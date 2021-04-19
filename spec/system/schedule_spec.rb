require 'rails_helper'

RSpec.describe "スケジュール関係のテスト", type: :system do
  before do
    create(:company)
    create(:employee, admin: false)
    visit login_path
    fill_in "session_email", with: Employee.first.email
    fill_in "session_password", with: "testtest"
    click_button "ログイン"
  end
  context "admin権限の無い従業員" do
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
        find(".fa-trash").click
      end
      expect(page).to have_content("予定を削除しました")
      expect(page).not_to have_content("資料作成")
    end
  end

end