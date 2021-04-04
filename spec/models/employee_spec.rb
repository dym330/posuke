require 'rails_helper'

RSpec.describe Employee, type: :model do
  before do
    create(:company)
  end

  context "実際に保存してみる" do
    it "有効な物は保存可能か？" do
      expect(build(:employee)).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "企業IDの空白" do
      expect(build(:employee, company_id: "")).to be_invalid
    end
    it "名前の空白" do
      expect(build(:employee, name: "")).to be_invalid
    end
    it "Eメールの空白" do
      expect(build(:employee, email: "")).to be_invalid
    end
    it "パスワードの空白" do
      expect(build(:employee, password: "")).to be_invalid
    end
    it "部署名の空白" do
      expect(build(:employee, department: "")).to be_invalid
    end
    it "入社日の空白" do
      expect(build(:employee, joining_date: "")).to be_invalid
    end
    it "管理権限の空白" do
      expect(build(:employee, admin: "")).to be_invalid
    end
    it "在籍状況" do
      expect(build(:employee, enrollment_status: "")).to be_invalid
    end
  end

  context "無効データの入力" do
    it "存在しないcompany_idの入力" do
      expect(build(:employee, company_id: Company.first.id + 1)).to be_invalid
    end
    it "入社日に数字以外のデータ" do
      expect(build(:employee, joining_date: "あああ")).to be_invalid
    end
    it "Eメールに日本語" do
      expect(build(:employee, email: "testtesあt.com")).to be_invalid
    end
    it "Eメールに@がない" do
      expect(build(:employee, email: "testtest.com")).to be_invalid
    end
    it "Eメールに@が複数存在" do
      expect(build(:employee, email: "test@@test.com")).to be_invalid
    end
    it "名前が21文字" do
      expect(build(:employee, name: "a" * 21)).to be_invalid
    end
    it "名前が21文字" do
      expect(build(:employee, department: "a" * 21)).to be_invalid
    end
  end
end
