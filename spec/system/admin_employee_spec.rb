require 'rails_helper'

RSpec.describe "admin権限を持つ従業員のテスト", type: :system do
  before do
    create(:company)
    create(:employee, admin: true)
    visit login_path
    fill_in "session_email", with: Employee.first.email
    fill_in "session_password", with: "testtest"
    click_button "ログイン"
  end
  let(:employee) {create(:employee)}

  context "従業員関係のテスト" do
    it "他従業員の編集ページへ行ける" do
      visit employee_path(employee)
      click_link "編集"
      expect(page).to have_content("従業員編集")
    end

    it "従業員の登録ができる" do
      count = Employee.count
      click_link "従業員新規登録"
      fill_in "employee_name", with: "新規太郎"
      fill_in "employee_email", with: "new@new.com"
      fill_in "employee_password", with: "password"
      fill_in "employee_password_confirmation", with: "password"
      fill_in "employee_department", with: "営業部"
      select "2020", from: "employee_joining_date_1i"
      select "12", from: "employee_joining_date_2i"
      select "31", from: "employee_joining_date_3i"
      click_button "登録"
      expect(page).to have_content("従業員の新規登録に成功しました")
      expect(Employee.count).to eq(count + 1)
    end

    it "不適切な内容の場合、従業員の登録に失敗" do
      count = Employee.count
      click_link "従業員新規登録"
      click_button "登録"
      expect(page).to have_content("名前を入力してください")
      expect(Employee.count).to eq(count)
    end

    it "従業員編集（管理権限、在籍状況）ができるか" do
      visit edit_employee_path(employee)
      expect(Employee.last.admin).to eq(false)
      expect(Employee.last.enrollment_status).to eq(true)
      select "管理者", from: "employee_admin"
      select "非在籍", from: "employee_enrollment_status"
      click_button "登録"
      expect(Employee.last.admin).to eq(true)
      expect(Employee.last.enrollment_status).to eq(false)
    end

    it "admin権限を持つ従業員が必ず1人以上存在" do
      visit edit_employee_path(Employee.first)
      select "非管理者", from: "employee_admin"
      click_button "登録"
      expect(page).to have_content("管理権限を持つ人は最低1人以上必要です")
      expect(Employee.first.admin).to eq(true)
    end
  end
end