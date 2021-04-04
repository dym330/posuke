class Employee < ApplicationRecord
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
