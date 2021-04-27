require 'rails_helper'

RSpec.describe "企業登録・編集のテスト", type: :system do
  before do
    create(:admin)
    visit new_admin_session_path
    fill_in "admin_email", with: "admin@admin.com"
    fill_in "admin_password", with: "password"
    click_button "ログイン"
  end
  let(:company) {create(:company)}
  context "企業登録" do
    it "適切な内容をフォームに入力" do
      expect(Company.count).to eq(0)
      expect(Employee.count).to eq(0)
      click_link "企業登録"
      fill_in "company_company_name", with: "テスト株式会社"
      fill_in "company_responsible_name", with: "テスト太郎"
      fill_in "company_postcode", with: "1234567"
      fill_in "company_address", with: "京都府宇治市平等院鳳凰堂1-1-1"
      fill_in "company_email", with: "test@test.com"
      fill_in "company_phone_number", with: "09012345678"
      click_button "登録"
      expect(current_path).to eq(admin_companies_path)
      expect(Company.count).to eq(1)
      expect(Employee.count).to eq(1)
    end

    it "不適切な内容(企業名空白)をフォームに入力" do
      expect(Company.count).to eq(0)
      expect(Employee.count).to eq(0)
      visit new_admin_company_path
      fill_in "company_responsible_name", with: "テスト太郎"
      fill_in "company_postcode", with: "1234567"
      fill_in "company_address", with: "京都府宇治市平等院鳳凰堂1-1-1"
      fill_in "company_email", with: "test@test.com"
      fill_in "company_phone_number", with: "09012345678"
      click_button "登録"
      expect(Company.count).to eq(0)
      expect(Employee.count).to eq(0)
      expect(page).to have_content "企業名を入力してください"
    end

    it "企業一覧が適切に表示" do
      company
      visit admin_companies_path
      expect(page).to have_content "テスト株式会社"
      expect(page).to have_content "大阪府テスト市テスト町１−２−３"
      expect(page).to have_content "0"
      expect(page).to have_content "利用中"
    end

    it "企業詳細が適切に表示" do
      visit admin_company_path(company)
      expect(page).to have_content "テスト株式会社"
      expect(page).to have_content "テスト太郎"
      expect(page).to have_content "1234567"
      expect(page).to have_content "大阪府テスト市テスト町１−２−３"
      expect(page).to have_content Company.first.email
      expect(page).to have_content "0"
      expect(page).to have_content "利用中"
    end

    it "企業編集が反映" do
      company
      visit admin_companies_path
      click_link "テスト株式会社"
      click_link "編集"
      fill_in "company_responsible_name", with: "テスト次郎"
      fill_in "company_postcode", with: "9876543"
      fill_in "company_address", with: "大阪府通天閣2-2-2"
      fill_in "company_email", with: "test123@test.com"
      select "利用停止", from: "company_usage_status"
      click_button "保存"
      expect(page).to have_content "テスト次郎"
      expect(page).to have_content "9876543"
      expect(page).to have_content "大阪府通天閣2-2-2"
      expect(page).to have_content "test123@test.com"
      expect(page).to have_content "利用停止"
    end

    it "不適切な内容の場合、編集の保存が失敗" do
      visit edit_admin_company_path(company)
      fill_in "company_company_name", with: ""
      fill_in "company_responsible_name", with: "テスト次郎"
      click_button "保存"
      expect(page).to have_content "企業名を入力してください"
      expect(Company.first.responsible_name).not_to eq("テスト次郎")
    end

    it "従業員の中で使用されているEメールを、企業登録時に使用した場合の新規登録が失敗" do
      create(:company)
      create(:employee, email: "test@test.com")
      visit new_admin_company_path
      fill_in "company_company_name", with: "テスト株式会社"
      fill_in "company_responsible_name", with: "テスト太郎"
      fill_in "company_postcode", with: "1234567"
      fill_in "company_address", with: "京都府宇治市平等院鳳凰堂1-1-1"
      fill_in "company_email", with: "test@test.com"
      fill_in "company_phone_number", with: "09012345678"
      click_button "登録"
      expect(page).to have_content "Eメールはすでに存在します"
    end
  end
end