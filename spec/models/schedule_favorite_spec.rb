require 'rails_helper'

RSpec.describe ScheduleFavorite, type: :model do
  before do
    create(:company)
    create(:employee)
    create(:schedule)
  end

  context "実際に保存してみる" do
    it "有効な物は保存可能か？" do
      expect(build(:schedule_favorite)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "従業員IDの空白" do
      expect(build(:schedule_favorite, employee_id: "")).to be_invalid
    end
    it "予定IDの空白" do
      expect(build(:schedule_favorite, schedule_id: "")).to be_invalid
    end
  end
end
