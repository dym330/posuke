class ContactMailer < ApplicationMailer
  def send_when_admin_reply(contact)
    @contact = contact
    if Rails.env.test?
      mail to: 'test@test.com'
      mail from: 'test@test.com'
    else
      mail to: ENV['MAIL_USERNAME']
    end
  end
end
