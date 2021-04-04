class Schedule < ApplicationRecord
  validates :title, presence: true, length: { in: 1..20 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_end_check
  validates :content, presence: true, length: { in: 1..1000 }
  validates :question
  validates :schedule_status, presence: true
  validates :comment_status, inclusion: { in: [true, false] }
  has_many :schedule_comments, dependent: :destroy
  has_many :schedule_favorites, dependent: :destroy
  belongs_to :employee

  def start_end_check
    errors.add(:end_time, "は開始時刻より遅い時間を選択してください") if self.start_time > self.end_time
  end
end
