class ApplicationMailer < ActionMailer::Base
  default from: "管理人<#{ENV['MAIL_USERNAME']}>"
  layout 'mailer'
end
