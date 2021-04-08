class Company < ApplicationRecord
  VALID_POSTCODE_REGEX = /\A\d{7}\z/
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/
  VALID_PHONE_REGEX = /\A\d{10,11}\z/

  validates :company_name, presence: true, length: { in: 1..140 }
  validates :responsible_name, presence: true, length: { in: 1..20 }
  validates :postcode, presence: true, format: { with: VALID_POSTCODE_REGEX }
  validates :address, presence: true, length: { in: 1..48 }
  validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }
  validates :usage_status, inclusion: { in: [true, false] }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_many :employees, dependent: :destroy

  #usage_statusのview表示
  def usage_status_display
    self.usage_status ? '利用中' : '利用停止'
  end
end
