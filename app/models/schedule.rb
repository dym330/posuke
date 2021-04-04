class Schedule < ApplicationRecord
  has_many :schedule_comments, dependent: :destroy
  has_many :schedule_favorites, dependent: :destroy
  belongs_to :schedule
end
