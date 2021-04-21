require 'rails_helper'

RSpec.describe "質問一覧機能のテスト", type: :system, js: true do
  before do
    create(:company)
    create(:employee, name: "テスト太郎")
    create(:employee, name: "テスト次郎")
    create(:schedule, title: "テストA資料作成", employee_id: Employee.first.id)
    create(:schedule, title: "テストB資料作成", employee_id: Employee.last.id)
    create(:schedule, title: "テストC資料作成", employee_id: Employee.first.id)
    create(:schedule, title: "テストD資料作成", employee_id: Employee.last.id)
    visit login_path
    fill_in "session_email", with: Employee.first.email
    fill_in "session_password", with: "testtest"
    click_button "ログイン"
  end

  it "従業員名、部分一致検索" do
    visit searches_path
    fill_in "search", with: "太"
    select "従業員名", from: "option"
    select "部分一致", from: "choice"
    click_button "検索"
    expect(page).to have_content("テストA資料作成")
    expect(page).not_to have_content("テストB資料作成")
    expect(page).to have_content("テストC資料作成")
    expect(page).not_to have_content("テストD資料作成")
  end

  it "従業員名、前方一致" do
    visit searches_path
    fill_in "search", with: "テスト"
    select "従業員名", from: "option"
    select "前方一致", from: "choice"
    click_button "検索"
    expect(page).to have_content("テストA資料作成")
    expect(page).to have_content("テストB資料作成")
    expect(page).to have_content("テストC資料作成")
    expect(page).to have_content("テストD資料作成")
  end

  it "従業員名、後方一致" do
    visit searches_path
    fill_in "search", with: "次郎"
    select "従業員名", from: "option"
    select "後方一致", from: "choice"
    click_button "検索"
    expect(page).not_to have_content("テストA資料作成")
    expect(page).to have_content("テストB資料作成")
    expect(page).not_to have_content("テストC資料作成")
    expect(page).to have_content("テストD資料作成")
  end

  it "従業員名、完全一致" do
    visit searches_path
    fill_in "search", with: "テスト次郎"
    select "従業員名", from: "option"
    select "完全一致", from: "choice"
    click_button "検索"
    expect(page).not_to have_content("テストA資料作成")
    expect(page).to have_content("テストB資料作成")
    expect(page).not_to have_content("テストC資料作成")
    expect(page).to have_content("テストD資料作成")
  end

  it "タイトル名、部分一致" do
    visit searches_path
    fill_in "search", with: "B"
    select "スケジュールタイトル", from: "option"
    select "部分一致", from: "choice"
    click_button "検索"
    expect(page).not_to have_content("テストA資料作成")
    expect(page).to have_content("テストB資料作成")
    expect(page).not_to have_content("テストC資料作成")
    expect(page).not_to have_content("テストD資料作成")
  end

  it "タイトル名、前方一致" do
    visit searches_path
    fill_in "search", with: "テストC"
    select "スケジュールタイトル", from: "option"
    select "前方一致", from: "choice"
    click_button "検索"
    expect(page).not_to have_content("テストA資料作成")
    expect(page).not_to have_content("テストB資料作成")
    expect(page).to have_content("テストC資料作成")
    expect(page).not_to have_content("テストD資料作成")
  end

  it "タイトル名、後方一致" do
    visit searches_path
    fill_in "search", with: "D資料作成"
    select "スケジュールタイトル", from: "option"
    select "後方一致", from: "choice"
    click_button "検索"
    expect(page).not_to have_content("テストA資料作成")
    expect(page).not_to have_content("テストB資料作成")
    expect(page).not_to have_content("テストC資料作成")
    expect(page).to have_content("テストD資料作成")
  end

  it "タイトル名、完全一致" do
    visit searches_path
    fill_in "search", with: "テストB資料作成"
    select "スケジュールタイトル", from: "option"
    select "完全一致", from: "choice"
    click_button "検索"
    expect(page).not_to have_content("テストA資料作成")
    expect(page).to have_content("テストB資料作成")
    expect(page).not_to have_content("テストC資料作成")
    expect(page).not_to have_content("テストD資料作成")
  end
end