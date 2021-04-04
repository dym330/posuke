require 'rails_helper'

RSpec.describe Schedule, type: :model do
  before do
    create(:company)
    create(:employee)
  end
  context "実際に保存してみる" do
    it "有効な物は保存可能か？" do
      expect(build(:schedule)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "従業員IDの空白" do
      expect(build(:schedule, employee_id: "")).to be_invalid
    end
    it "タイトルの空白" do
      expect(build(:schedule, title: "")).to be_invalid
    end
    it "内容の空白" do
      expect(build(:schedule, content: "")).to be_invalid
    end
    it "予定ステータスの空白" do
      expect(build(:schedule, schedule_status: "")).to be_invalid
    end
    it "コメントステータスの空白" do
      expect(build(:schedule, comment_status: "")).to be_invalid
    end
  end
  context "無効データの入力" do
    it "存在しないemployee_idの入力" do
      expect(build(:schedule, employee_id: Employee.first.id + 1)).to be_invalid
    end
    it "タイトルが21文字" do
      expect(build(:schedule, title: "a" * 21)).to be_invalid
    end
    it "終了時間が開始時間より前" do
      expect(build(:schedule, start_time: Date.today, end_time: Date.yesterday)).to be_invalid
    end
    it "内容が1001文字" do
      expect(build(:schedule, content: "a" * 1001)).to be_invalid
    end
    it "質問が1001文字" do
      expect(build(:schedule, question: "a" * 1001)).to be_invalid
    end
  end
end
