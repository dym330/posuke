require 'rails_helper'

RSpec.describe "従業員のログイン、ログアウトテスト", type: :system do
  before do
    create(:company)
    create(:employee)
    visit login_path
  end

  context "適切な内容でのテスト" do
    it "ログイン、ログアウト可能か" do
      fill_in "session_email", with: Employee.first.email
      fill_in "session_password", with: "testtest"
      click_button "ログイン"
      expect(current_path).to eq(schedules_path)
      click_link "ログアウト"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("従業員ログイン")
    end
  end

  context "不適切な内容でのテスト" do
    it "パスワードが不適切(空欄)" do
      fill_in "session_email", with: Employee.first.email
      click_button "ログイン"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Eメールまたはパスワードが違います。")
    end
    it "パスワードが不適切(入力内容が違う)" do
      fill_in "session_email", with: Employee.first.email
      fill_in "session_password", with: "TESTTEST"
      click_button "ログイン"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Eメールまたはパスワードが違います。")
    end
    it "Eメールが不適切(空欄)" do
      fill_in "session_password", with: "testtest"
      click_button "ログイン"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Eメールまたはパスワードが違います。")
    end
    it "Eメールが不適切(入力内容が違う)" do
      fill_in "session_email", with: "not@test.com"
      fill_in "session_password", with: "testtest"
      click_button "ログイン"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Eメールまたはパスワードが違います。")
    end
    it "非在籍者はログインができない" do
      create(:employee, enrollment_status: false, email: "status@false.com")
      fill_in "session_email", with: "status@false.com"
      fill_in "session_password", with: "testtest"
      click_button "ログイン"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("ログインが認められませんでした。")
    end

    it "会社が利用停止した場合、ログインができない" do
      create(:company, usage_status: false)
      create(:employee, email: "status@false.com", company_id: Company.last.id)
      fill_in "session_email", with: "status@false.com"
      fill_in "session_password", with: "testtest"
      click_button "ログイン"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("ログインが認められませんでした。")
    end
  end
end