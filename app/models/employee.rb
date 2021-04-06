class Employee < ApplicationRecord
  validates :name, presence: true, length: { in: 1..20 }
  validates :department, presence: true, length: { in: 1..20 }
  validates :joining_date, presence: true
  validates :admin, inclusion: { in: [true, false] }
  validates :enrollment_status, inclusion: { in: [true, false] }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company
  has_many :schedules, dependent: :destroy
  has_many :schedule_comments, dependent: :destroy
  has_many :schedule_favorites, dependent: :destroy
  has_many :group, dependent: :destroy
  has_many :group_relationships

  
end
