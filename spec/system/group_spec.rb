require 'rails_helper'

RSpec.describe "グループ機能のテスト", type: :system do
  before do
    create(:company)
    create(:employee, name: "テストA")
    create(:employee, name: "テストB")
    create(:employee, name: "テストC")
    create(:employee, name: "テストD")
    create(:employee, name: "テストE")
    visit login_path
    fill_in "session_email", with: Employee.first.email
    fill_in "session_password", with: "testtest"
    click_button "ログイン"
  end

  it "グループ新規登録" do
    visit groups_path
    click_link "新規作成"
    fill_in "group_name", with: "テストグループ"
    click_button "登録"
    expect(page).to have_content("グループを作成しました。続いて、従業員の登録をお願いします。")
    expect(current_path).to eq(new_group_group_relationships_path(Group.last.id))
    visit groups_path
    expect(page).to have_content("テストグループ")
  end

  it "不適切な内容の場合、グループ新規登録ができない" do
    visit groups_path
    click_link "新規作成"
    fill_in "group_name", with: ""
    click_button "登録"
    expect(page).to have_content("名前を入力してください")
    expect(Group.count).to eq(0)
  end

  it "グループ名編集" do
    create(:group)
    visit groups_path
    find(".fa-edit").click
    fill_in "group_name", with: "変更グループ"
    click_button "登録"
    expect(current_path).to eq(group_path(Group.last.id))
    visit groups_path
    expect(page).to have_content("変更グループ")
  end

  it "不適切な内容の場合、グループ名の編集ができない" do
    create(:group)
    visit edit_group_path(Group.last.id)
    fill_in "group_name", with: ""
    click_button "登録"
    expect(page).to have_content("名前を入力してください")
  end

  it "従業員の登録", js: true do
    create(:group)
    create(:schedule, employee_id: Employee.second.id)
    create(:schedule, employee_id: Employee.last.id)
    visit groups_path
    find(".fa-users-cog").click
    expect(page).not_to have_content(Employee.first.name)
    find("#employee_id#{Employee.second.id} .fa-plus-circle").click
    find("#employee_id#{Employee.last.id} .fa-plus-circle").click
    visit groups_path
    click_link Group.first.name
    expect(page).to have_content(Employee.second.name)
    expect(page).to have_content(Employee.last.name)
    visit new_group_group_relationships_path(Group.first.id)
    find("#employee_id#{Employee.second.id} .fa-trash-alt").click
    find("#employee_id#{Employee.last.id} .fa-trash-alt").click
    visit groups_path
    click_link Group.first.name
    expect(page).not_to have_content(Employee.second.name)
    expect(page).not_to have_content(Employee.last.name)
  end

  it "グループの削除", js: true do
    create(:group)
    visit groups_path
    expect(page).to have_content("営業部")
    page.accept_confirm do
      find(".fa-trash-alt").click
    end
    expect(page).not_to have_content("営業部")
  end

  it "他従業員が作成したグループの編集はできない" do
    create(:group, employee_id: Employee.second.id)
    visit edit_group_path(Group.first.id)
    expect(current_path).to eq(schedules_path)
    expect(page).to have_content("アクセスしたページには権限が無いため閲覧できません。")
  end
end