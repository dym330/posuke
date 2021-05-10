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
  enum schedule_status: { 未質問: 0, 質問中: 1, 解決済質問: 2 }
  scope :recent, ->(page) { order(id: :DESC).page(page).per(10) }

  # nilデータでは、>が使えないため、nil?を最初に確認している
  def start_end_check
    return if start_time.nil? || end_time.nil?

    return unless start_time > end_time

    errors.add(:start_time, 'は終了時刻より早い時間を選択してください')
    errors.add(:end_time, 'は開始時刻より遅い時間を選択してください')
  end

  # XX年XX月XX日　XX:XX　〜　(XX年XX月XX日)　XX:XX の形に変換
  def start_and_end_time
    if start_time.strftime('%y年%m月%d日') == end_time.strftime('%y年%m月%d日')
      "#{start_time.strftime('%y年%m月%d日 %H:%M')} 〜 #{end_time.strftime('%H:%M')}"
    else
      "#{start_time.strftime('%y年%m月%d日 %H:%M')} 〜 #{end_time.strftime('%y年%m月%d日 %H:%M')}"
    end
  end

  # いいねされているかどうかを真偽値で返す
  def favorited_by?(employee)
    !!schedule_favorites.find { |i| i[:employee_id] == employee.id }
  end

  # 検索機能：部分一致、前方一致、後方一致、完全一致
  def self.search(search, how_search, employee_ids, page)
    case how_search
    when '1'
      includes(:employee, :schedule_comments, :schedule_favorites)
        .where(['title LIKE ?', "%#{search}%"])
        .where(employee_id: employee_ids)
        .recent(page)
    when '2'
      includes(:employee, :schedule_comments, :schedule_favorites)
        .where(['title LIKE ?', "#{search}%"])
        .where(employee_id: employee_ids)
        .recent(page)
    when '3'
      includes(:employee, :schedule_comments, :schedule_favorites)
        .where(['title LIKE ?', "%#{search}"])
        .where(employee_id: employee_ids)
        .recent(page)
    when '4'
      includes(:employee, :schedule_comments, :schedule_favorites)
        .where(['title LIKE ?', "#{search}"])
        .where(employee_id: employee_ids)
        .recent(page)
    end
  end

  def self.employees_search(employee_ids, page)
    includes(:employee, :schedule_comments, :schedule_favorites)
      .where(employee_id: employee_ids)
      .recent(page)
  end

  # schedule_statusでcssを切り替えたいために設定
  def css_name
    case schedule_status
    when '質問中'
      'question'
    when '解決済質問'
      'solution'
    end
  end
end
