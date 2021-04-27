class Schedule < ApplicationRecord
  validates :title, presence: true, length: { in: 1..20 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_end_check
  validates :content, presence: true, length: { in: 1..1000 }
  validates :question, length: { maximum: 1000 }
  validates :schedule_status, presence: true
  validates :comment_status, inclusion: { in: [true, false] }
  has_many :schedule_comments, dependent: :destroy
  has_many :schedule_favorites, dependent: :destroy
  belongs_to :employee
  enum schedule_status: {未質問:0, 質問中:1, 解決済質問:2}

  # nilデータでは、>が使えないため、nil?を最初に確認している
  def start_end_check
    unless self.start_time.nil? && self.end_time.nil?
      if self.start_time > self.end_time
        errors.add(:start_time, "は終了時刻より早い時間を選択してください") if self.start_time > self.end_time
        errors.add(:end_time, "は開始時刻より遅い時間を選択してください") if self.start_time > self.end_time
      end
    end
  end

  #XX年XX月XX日　XX:XX　〜　(XX年XX月XX日)　XX:XX の形に変換
  def start_and_end_time
    if self.start_time.strftime("%y年%m月%d日") == self.end_time.strftime("%y年%m月%d日")
      "#{self.start_time.strftime("%y年%m月%d日 %H:%M")} 〜 #{self.end_time.strftime("%H:%M")}"
    else
      "#{self.start_time.strftime("%y年%m月%d日 %H:%M")} 〜 #{self.end_time.strftime("%y年%m月%d日 %H:%M")}"
    end
  end

  #いいねされているかどうかを真偽値で返す
  def favorited_by?(employee)
    !!schedule_favorites.find{ |i| i[:employee_id] == employee.id }
  end

  #検索機能：部分一致、前方一致、後方一致、完全一致
  def self.search(search, how_search)
    if how_search == "1"
      self.where(['title LIKE ?', "%#{search}%"])
    elsif how_search == "2"
      self.where(['title LIKE ?', "#{search}%"])
    elsif how_search == "3"
      self.where(['title LIKE ?', "%#{search}"])
    elsif how_search == "4"
      self.where(['title LIKE ?', "#{search}"])
    end
  end

  def css_name
    if schedule_status == "質問中"
      "question"
    elsif schedule_status == "解決済質問"
      "solution"
    end
  end

end
