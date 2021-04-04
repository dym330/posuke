require 'rails_helper'

RSpec.describe Contact, type: :model do
  context "実際に保存してみる" do
    it "有効な物は保存可能か？" do
      expect(build(:contact)).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "企業名の空白" do
      expect(build(:contact, company_name: "")).to be_invalid
    end
    it "担当者名の空白" do
      expect(build(:contact, responsible_name: "")).to be_invalid
    end
    it "Eメールの空白" do
      expect(build(:contact, email: "")).to be_invalid
    end
    it "内容の空白" do
      expect(build(:contact, message: "")).to be_invalid
    end
  end

  context "無効データの入力" do
    it "141文字の企業名" do
      expect(build(:contact, company_name: "a" * 141)).to be_invalid
    end
    it "21文字の担当者" do
      expect(build(:contact, responsible_name: "a" * 21)).to be_invalid
    end
    it "Eメールに日本語" do
      expect(build(:contact, email: "testtesあt.com")).to be_invalid
    end
    it "Eメールに@がない" do
      expect(build(:contact, email: "testtest.com")).to be_invalid
    end
    it "Eメールに@が複数存在" do
      expect(build(:contact, email: "test@@test.com")).to be_invalid
    end
    it "内容が1001文字" do
      expect(build(:contact, message: "a" * 1001)).to be_invalid
    end
  end
end
