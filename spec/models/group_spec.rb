require 'rails_helper'

RSpec.describe Group, type: :model do
  before do
    create(:company)
    create(:employee)
  end

  context "実際に保存してみる" do
    it "有効な物は保存可能か？" do
      expect(build(:group)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "従業員IDの空白" do
      expect(build(:group, employee_id: "")).to be_invalid
    end
    it "名称の空白" do
      expect(build(:group, name: "")).to be_invalid
    end
  end
  context "無効データの入力" do
    it "21文字の名称" do
      expect(build(:group, name: "a" * 21)).to be_invalid
    end
  end
end
