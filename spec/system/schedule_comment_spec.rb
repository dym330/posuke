require 'rails_helper'

RSpec.describe "スケジュールコメント機能のテスト", type: :system do
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

  it "コメント投稿ができるか", js: true do
    visit schedule_path(other_employee_schedule)
    expect(page).to have_selector "#comment_count", text: "0"
    fill_in "comment_text_area", with: "頑張ってください"
    click_button "送信"
    expect(page).to have_content "頑張ってください"
    expect(page).to have_content Employee.first.name
    expect(page).to have_selector "#comment_count", text: "1"
  end

  it "不敵な内容ではコメントが投稿できない", js: true do
    visit schedule_path(other_employee_schedule)
    fill_in "comment_text_area", with: ""
    click_button "送信"
    expect(page).to have_content "コメントが正しく保存されませんでした。"
    expect(ScheduleComment.count).to eq(0)
  end

  it "コメント削除できるか", js: true do
    other_employee_schedule
    comment = create(:schedule_comment)
    visit schedule_path(other_employee_schedule)
    expect(page).to have_content "頑張れ！"
    page.accept_confirm do
      find("#comment_#{comment.id} .fa-trash-alt").click
    end
    expect(page).not_to have_content "頑張れ！"
    expect(page).to have_content "コメントを削除しました"
  end
end