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

  #enrollment_statusのview表示
  def enrollment_status_display
    self.enrollment_status ? '在籍中' : '非在籍'
  end

  def self.search(search, how_search)
    if how_search == "1"
      self.where(['name LIKE ?', "%#{search}%"])
    elsif how_search == "2"
      self.where(['name LIKE ?', "#{search}%"])
    elsif how_search == "3"
      self.where(['name LIKE ?', "%#{search}"])
    elsif how_search == "4"
      self.where(['name LIKE ?', "#{search}"])
    end
  end
end
