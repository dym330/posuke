require 'rails_helper'

RSpec.describe "管理者のログイン、ログアウトテスト", type: :system do
  before do
    create(:admin)
    visit new_admin_session_path
  end

  context "適切な内容でのテスト" do
    it "ログイン、ログアウト可能か" do
      fill_in "admin_email", with: "admin@admin.com"
      fill_in "admin_password", with: "password"
      click_button "ログイン"
      expect(current_path).to eq(admin_companies_path)
      click_link "ログアウト"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("管理者ログイン")
    end
  end

  context "不適切な内容でのテスト" do
    it "パスワードが不適切(空欄)" do
      fill_in "admin_email", with: "admin@admin.com"
      click_button "ログイン"
      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content("Eメールまたはパスワードが違います。")
    end
    it "パスワードが不適切(入力内容が違う)" do
      fill_in "admin_email", with: "admin@admin.com"
      fill_in "admin_password", with: "PASSWORD"
      click_button "ログイン"
      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content("Eメールまたはパスワードが違います。")
    end
    it "Eメールが不適切(空欄)" do
      fill_in "admin_password", with: "password"
      click_button "ログイン"
      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content("Eメールまたはパスワードが違います。")
    end
    it "Eメールが不適切(入力内容が違う)" do
      fill_in "admin_email", with: "admin1@admin.com"
      fill_in "admin_password", with: "password"
      click_button "ログイン"
      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content("Eメールまたはパスワードが違います。")
    end
  end
end