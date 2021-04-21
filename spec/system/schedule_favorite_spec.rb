require 'rails_helper'

RSpec.describe "スケジュールいいね機能のテスト", type: :system do
  let(:other_employee) { create(:employee) }
  let(:other_employee_schedule) { create(:schedule, employee_id: other_employee.id) }

  before do
    create(:company)
    create(:employee)
    visit login_path
    fill_in "session_email", with: Employee.first.email
    fill_in "session_password", with: "testtest"
    click_button "ログイン"
  end

  it "いいねボタン機能", js: true do
    visit schedule_path(other_employee_schedule)
    expect(page).to have_selector "#favorite-count-#{other_employee_schedule.id}", text: "0"
    find(".fa-heart").click
    expect(page).to have_selector "#favorite-count-#{other_employee_schedule.id}", text: "1"
    find(".icon-color-red").click
    expect(page).to have_selector "#favorite-count-#{other_employee_schedule.id}", text: "0"
  end

end