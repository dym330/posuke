require 'rails_helper'

RSpec.describe Admin, type: :model do
  context "実際に保存してみる" do
    it "有効な物は保存可能か？" do
      expect(build(:admin)).to be_valid
    end
  end
end
