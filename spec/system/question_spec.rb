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

  it "質問一覧が正しく表示されているか" do
    create(:schedule)
    create(:schedule)
    create(:schedule, question: "質問内容A", schedule_status: 1)
    create(:schedule, question: "質問内容B", schedule_status: 2)
    create(:schedule, question: "質問内容C", schedule_status: 1)
    create(:schedule, question: "質問内容D", schedule_status: 2)
    visit questions_path
    expect(page).to have_content("質問内容A")
    expect(page).to have_content("質問内容C")
  end

end