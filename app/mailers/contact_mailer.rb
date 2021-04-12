class ContactMailer < ApplicationMailer
  def send_when_admin_reply(contact)
    @contact = contact
    mail to: ENV["MAIL_USERNAME"]
  end
end
