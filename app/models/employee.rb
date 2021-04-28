class Employee < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/
  attr_accessor :current_password

  validates :name, presence: true, length: { in: 1..20 }
  validates :department, presence: true, length: { in: 1..20 }
  validates :joining_date, presence: true
  validates :admin, inclusion: { in: [true, false] }
  validates :enrollment_status, inclusion: { in: [true, false] }
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, presence: true, length: { minimum: 6 },
                       allow_blank: true, on: :update
  attachment :image, type: :image

  belongs_to :company
  has_many :schedules, dependent: :destroy
  has_many :schedule_comments, dependent: :destroy
  has_many :schedule_favorites, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :group_relationships, dependent: :destroy

  # enrollment_statusのview表示
  def enrollment_status_display
    enrollment_status ? '在籍中' : '非在籍'
  end

  def self.search(search, how_search, employee)
    case how_search
    when '1'
      where(['name LIKE ?', "%#{search}%"]).where(company_id: employee.company_id)
    when '2'
      where(['name LIKE ?', "#{search}%"]).where(company_id: employee.company_id)
    when '3'
      where(['name LIKE ?', "%#{search}"]).where(company_id: employee.company_id)
    when '4'
      where(['name LIKE ?', "#{search}"]).where(company_id: employee.company_id)
    end
  end
end
