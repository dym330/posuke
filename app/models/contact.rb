class Contact < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/
  VALID_PHONE_REGEX = /\A\d{10,11}\z/

  validates :company_name, presence: true, length: { in: 1..140 }
  validates :responsible_name, presence: true, length: { in: 1..20 }
  validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :message, presence: true, length: { in: 1..1000 }

  has_many :employees, dependent: :destroy
end
