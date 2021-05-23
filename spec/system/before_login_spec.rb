require 'rails_helper'

RSpec.describe "ログイン前のテスト", type: :system do
  context "ログイン前に遷移可能ページ" do
    it "TOPページ画面に飛べる" do
      visit root_path
      expect(current_path).to eq "/"
    end

    it "管理者ログインページ" do
      visit new_admin_session_path
      expect(current_path).to eq "/admin/sign_in"
    end

    it "従業員ログインページ" do
      visit login_path
      expect(current_path).to eq "/login"
    end
  end

  context "ログイン前に遷移不可ページに飛んだ際、ログインページに遷移するか" do
    before do
      create(:admin)
      create(:company)
      create(:employee)
      create(:group)
      create(:schedule)
      create(:contact)
    end

    it "ホーム画面" do
      visit schedules_path
      expect(current_path).to eq "/login"
    end

    it "スケジュール新規作成画面" do
      visit new_schedule_path
      expect(current_path).to eq "/login"
    end

    it "スケジュール編集画面" do
      visit new_schedule_path(Schedule.first)
      expect(current_path).to eq "/login"
    end

    it "スケジュール詳細画面" do
      visit schedule_path(Schedule.first)
      expect(current_path).to eq "/login"
    end

    it "従業員パスワード変更画面" do
      visit employee_password_path(Employee.first)
      expect(current_path).to eq "/login"
    end

    it "従業員カレンダー画面" do
      visit employee_calendars_path(Employee.first)
      expect(current_path).to eq "/login"
    end

    it "従業員新規作成画面" do
      visit new_employee_path
      expect(current_path).to eq "/login"
    end

    it "従業員編集画面" do
      visit edit_employee_path(Employee.first)
      expect(current_path).to eq "/login"
    end

    it "従業員詳細画面" do
      visit employee_path(Employee.first)
      expect(current_path).to eq "/login"
    end

    it "質問一覧画面" do
      visit questions_path
      expect(current_path).to eq "/login"
    end

    it "返信一覧画面" do
      visit replies_path
      expect(current_path).to eq "/login"
    end

    it "検索画面" do
      visit searches_path
      expect(current_path).to eq "/login"
    end

    it "グループの従業員登録画面" do
      visit new_group_group_relationships_path(Group.first)
      expect(current_path).to eq "/login"
    end

    it "グループ一覧画面" do
      visit groups_path
      expect(current_path).to eq "/login"
    end

    it "グループ新規作成" do
      visit new_group_path
      expect(current_path).to eq "/login"
    end

    it "グループ編集画面" do
      visit edit_group_path(Group.first)
      expect(current_path).to eq "/login"
    end

    it "グループ詳細画面" do
      visit group_path(Group.first)
      expect(current_path).to eq "/login"
    end

    it "グループ従業員リスト画面" do
      visit group_employee_list_path(Group.first)
      expect(current_path).to eq "/login"
    end

    it "企業一覧画面" do
      visit admin_companies_path
      expect(current_path).to eq "/admin/sign_in"
    end

    it "企業新規作成画面" do
      visit new_admin_company_path
      expect(current_path).to eq "/admin/sign_in"
    end

    it "企業詳細画面" do
      visit admin_company_path(Group.first)
      expect(current_path).to eq "/admin/sign_in"
    end

    it "問い合わせ一覧画面" do
      visit admin_contacts_path
      expect(current_path).to eq "/admin/sign_in"
    end

    it "問い合わせ詳細画面" do
      visit admin_contact_path(Contact.first)
      expect(current_path).to eq "/admin/sign_in"
    end
  end

  context "ヘッダーの遷移" do
    it "タイトルを押すとTOPページに遷移するか" do
      visit root_path
      click_link "ポスケ！"
      expect(current_path).to eq "/"
    end

    it "タイトルを押すとTOPページに遷移するか" do
      visit root_path
      click_link "ポスケ！"
      expect(current_path).to eq "/"
    end

    it "管理者ログインを押すと管理者ログインページに遷移するか" do
      visit root_path
      click_link "管理ページログイン"
      expect(current_path).to eq "/admin/sign_in"
    end

    it "従業員ログインを押すと従業員ログインページに遷移するか" do
      visit root_path
      click_link "従業員ログイン"
      expect(current_path).to eq "/login"
    end
  end
end