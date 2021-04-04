require 'rails_helper'

RSpec.describe Company, type: :model do
  context "実際に保存してみる" do
    it "有効な物は保存可能か？" do
      expect(build(:company)).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "企業名の空白" do
      expect(build(:company, company_name: "")).to be_invalid
    end
    it "担当者名の空白" do
      expect(build(:company, responsible_name: "")).to be_invalid
    end
    it "郵便番号の空白" do
      expect(build(:company, postcode: "")).to be_invalid
    end
    it "住所の空白" do
      expect(build(:company, address: "")).to be_invalid
    end
    it "電話番号の空白" do
      expect(build(:company, phone_number: "")).to be_invalid
    end
    it "利用状況の空白" do
      expect(build(:company, usage_status: "")).to be_invalid
    end
  end

  context "無効データの入力" do
    it "郵便番号に数字以外の文字列" do
      expect(build(:company, postcode: "あああああああ")).to be_invalid
    end
    it "郵便番号に6桁の数字" do
      expect(build(:company, postcode: "123456")).to be_invalid
    end
    it "郵便番号に8桁の数字" do
      expect(build(:company, postcode: "12345678")).to be_invalid
    end
    it "Eメールに日本語" do
      expect(build(:company, email: "testtesあt.com")).to be_invalid
    end
    it "Eメールに@がない" do
      expect(build(:company, email: "testtest.com")).to be_invalid
    end
    it "Eメールに@が複数存在" do
      expect(build(:company, email: "test@@test.com")).to be_invalid
    end
    it "電話番号に文字列" do
      expect(build(:company, email: "090123456a1")).to be_invalid
    end
    it "電話番号が9桁" do
      expect(build(:company, email: "012345678")).to be_invalid
    end
    it "電話番号11桁" do
      expect(build(:company, email: "01234567890")).to be_invalid
    end
    it "企業名141文字" do
      expect(build(:company, company_name: "a" * 141)).to be_invalid
    end
    it "企業名21文字" do
      expect(build(:company, responsible_name: "a" * 21)).to be_invalid
    end
    it "企業名49文字" do
      expect(build(:company, address: "a" * 49)).to be_invalid
    end
  end
end
