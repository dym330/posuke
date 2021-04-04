require 'rails_helper'

RSpec.describe ScheduleComment, type: :model do
  before do
    create(:company)
    create(:employee)
    create(:schedule)
  end

  context "実際に保存してみる" do
    it "有効な物は保存可能か？" do
      expect(build(:schedule_comment)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "従業員IDの空白" do
      expect(build(:schedule_comment, employee_id: "")).to be_invalid
    end
    it "予定IDの空白" do
      expect(build(:schedule_comment, schedule_id: "")).to be_invalid
    end
    it "投稿内容の空白" do
      expect(build(:schedule_comment, comment: "")).to be_invalid
    end
  end
  context "無効データの入力" do
    it "1001文字のコメント" do
      expect(build(:schedule_comment, comment: "a" * 1001)).to be_invalid
    end
  end
end
