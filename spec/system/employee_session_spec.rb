require 'rails_helper'

RSpec.describe "従業員のログイン、ログアウトテスト", type: :system do
  before do
    create(:company)
    create(:employee)
    visit login_path
  end

  context "適切な内容でのテスト" do
    it "ログイン、ログアウト可能か" do
      fill_in "session_email", with: "test@test.com"
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
      fill_in "session_email", with: "test@test.com"
      click_button "ログイン"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Eメールまたはパスワードが違います。")
    end
    it "パスワードが不適切(入力内容が違う)" do
      fill_in "session_email", with: "test@test.com"
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
      fill_in "session_email", with: "test1@test.com"
      fill_in "session_password", with: "testtest"
      click_button "ログイン"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Eメールまたはパスワードが違います。")
    end
  end
end