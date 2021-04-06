class Employee < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/
  validates :name, presence: true, length: { in: 1..20 }
  validates :department, presence: true, length: { in: 1..20 }
  validates :joining_date, presence: true
  validates :admin, inclusion: { in: [true, false] }
  validates :enrollment_status, inclusion: { in: [true, false] }
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness:true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  attachment :image

  belongs_to :company
  has_many :schedules, dependent: :destroy
  has_many :schedule_comments, dependent: :destroy
  has_many :schedule_favorites, dependent: :destroy
  has_many :group, dependent: :destroy
  has_many :group_relationships
end
