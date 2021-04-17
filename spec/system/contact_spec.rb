require 'rails_helper'

RSpec.describe "問い合わせフォームのテスト", type: :system do
  context "適切な内容入力時のテスト" do
    before do
      visit root_path
      fill_in "contact_company_name", with: "株式会社テスト"
      fill_in "contact_responsible_name", with: "テスト次郎"
      fill_in "contact_email", with: "test@test.com"
      fill_in "contact_phone_number", with: "09011223344"
      fill_in "contact_message", with: "検討します"
      click_button "送信"
      @mail = ActionMailer::Base.deliveries.last
    end

    it "Contactsテーブルに送信内容が保存されているか" do
      expect(Contact.count).to eq(1)
      expect(Contact.first.responsible_name).to eq("テスト次郎")
    end
    it "メールが送信されているか" do
      expect(@mail.from.first).to eq(ENV["MAIL_USERNAME"])
      expect(@mail.to.first).to eq(ENV["MAIL_USERNAME"])
      expect(@mail.body).to have_content "株式会社テスト"
      expect(@mail.body).to have_content "test@test.com"
      expect(@mail.body).to have_content "09011223344"
      expect(@mail.body).to have_content "検討します"
    end
    it "flashメッセージがでているかどうか" do
      expect(page).to have_content "問い合わせ内容を弊社担当へ送信いたしました。確認後、担当よりご連絡致します。"
    end
  end

  context "不適切な入力の場合" do
    before do
      visit root_path
      fill_in "contact_company_name", with: ""
      fill_in "contact_responsible_name", with: "テスト次郎"
      fill_in "contact_email", with: "test@test.com"
      fill_in "contact_phone_number", with: "09011223344"
      fill_in "contact_message", with: "検討します"
      click_button "送信"
    end
    it "メールは送信されていない" do
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
    it "不足内容のエラー表示" do
      expect(page).to have_content "企業名を入力してください"
    end
    it "モデルに保存がされていない" do
      expect(Contact.count).to eq(0)
    end
  end

end