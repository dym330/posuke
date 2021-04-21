require 'rails_helper'

RSpec.describe "質問一覧機能のテスト", type: :system do
  before do
    create(:company)
    create(:employee, admin: false)
    visit login_path
    fill_in "session_email", with: Employee.first.email
    fill_in "session_password", with: "testtest"
    click_button "ログイン"
  end

  it "返信一覧が正しく表示されているか", js: true do
    other_employee = create(:employee, admin: false)
    other_employee_schedule = create(:schedule, employee_id: other_employee.id)
    visit schedule_path(other_employee_schedule)
    fill_in "comment_text_area", with: "頑張ってください"
    click_button "送信"
    click_link "ログアウト"
    visit login_path
    fill_in "session_email", with: other_employee.email
    fill_in "session_password", with: "testtest"
    click_button "ログイン"
    visit replies_path
    expect(page).to have_content("資料作成")
    expect(page).to have_selector ".badge-danger", text: "1"
    click_link "schedule-post-#{other_employee_schedule.id}"
    expect(page).not_to have_selector ".badge-danger"
    visit replies_path
    expect(page).not_to have_content("資料作成")
  end
end