require 'rails_helper'

RSpec.describe "admin権限のない従業員のテスト", type: :system do
  before do
    create(:company)
    create(:employee, admin: false)
    visit login_path
    fill_in "session_email", with: Employee.first.email
    fill_in "session_password", with: "testtest"
    click_button "ログイン"
  end
  let(:employee) {create(:employee)}
  context "従業員関係のテスト" do
    it "従業員の新規登録ページには行けない" do
      expect(page).not_to have_content("従業員新規登録")
      visit new_employee_path
      expect(current_path).to eq(schedules_path)
      expect(page).to have_content("アクセスしたページには権限が無いため閲覧できません")
    end
  
    it "他従業員の編集ページには行けない" do
      visit employee_path(Employee.first)
      expect(page).to have_link("編集")
      visit employee_path(employee)
      expect(page).not_to have_link("編集")
      visit edit_employee_path(employee)
      expect(current_path).to eq(schedules_path)
      expect(page).to have_content("アクセスしたページには権限が無いため閲覧できません")
    end
  
    it "従業員の編集ができるか" do
      expect(Employee.first.image_id).to eq("")
      visit edit_employee_path(Employee.first)
      expect(page).not_to have_content("管理権限")
      expect(page).not_to have_content("在籍状況")
      fill_in "employee_name", with: "編集太郎"
      fill_in "employee_email", with: "edit@edit.com"
      attach_file "employee_image", "#{Rails.root}/db/fixtures/employee_image_1.png"
      fill_in "employee_department", with: "営業部"
      select "2020", from: "employee_joining_date_1i"
      select "12", from: "employee_joining_date_2i"
      select "31", from: "employee_joining_date_3i"
      click_button "登録"
      expect(page).to have_content("従業員の更新に成功しました")
      expect(page).to have_content("2020-12-31")
      expect(page).to have_content("営業部")
      expect(page).to have_content("編集太郎")
      expect(Employee.first.image_id).not_to eq("")
      click_link "ログアウト"
      visit login_path
      fill_in "session_email", with: "edit@edit.com"
      fill_in "session_password", with: "testtest"
      click_button "ログイン"
      expect(current_path).to eq(schedules_path)
    end
  
    it "従業員のパスワードの編集ができるか" do
      visit edit_employee_path(Employee.first)
      click_link "パスワードの変更はこちら"
      fill_in "employee_password", with: "changepass"
      fill_in "employee_password_confirmation", with: "changepass"
      click_button "保存"
      click_link "ログアウト"
      visit login_path
      fill_in "session_email", with: Employee.first.email
      fill_in "session_password", with: "changepass"
      click_button "ログイン"
      expect(current_path).to eq(schedules_path)
    end
  
    it "不適切な内容（名前空欄）での従業員の編集" do
      visit edit_employee_path(Employee.first)
      fill_in "employee_name", with: ""
      click_button "登録"
      expect(page).to have_content("名前を入力してください")
    end
  
    it "不適切な内容（パスワード空欄）での従業員の編集" do
      visit employee_password_path(Employee.first)
      click_button "保存"
      expect(current_path).to eq(employee_path(Employee.first))
      expect(page).to have_content("パスワードが空白であったため更新はされませんでした")
    end
  end


  
end
