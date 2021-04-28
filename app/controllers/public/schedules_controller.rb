class Public::SchedulesController < ApplicationController
  before_action :check_employee_signed
  before_action :sidebar_questions_count
  before_action :sidebar_replies_count, expect: [:show]
  before_action :check_admin_or_current_employee, only: [:edit, :destroy]
  def index
    @schedules = Schedule.includes(:employee, :schedule_comments, :schedule_favorites)
                         .where(employee_id: @employee_ids_in_current_company)
                         .order(id: :DESC)
                         .page(params[:page]).per(10)
  end

  def new
    @schedule = Schedule.new
  end

  def edit; end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      question_status_check(@schedule)
      redirect_to schedule_path(@schedule), flash: { success: '予定を更新しました。' }
    else
      render 'edit'
    end
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.employee_id = current_employee.id
    if @schedule.save
      redirect_to schedules_path, flash: { success: '予定を登録しました。' }
    else
      render 'new'
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
    @schedule_comment = ScheduleComment.new
    if @schedule.comment_status == true && current_employee.id == @schedule.employee_id
      @schedule.update(comment_status: false)
    end
    sidebar_replies_count
  end

  def destroy
    Schedule.find(params[:id]).destroy
    flash[:success] = '予定を削除しました。'
    redirect_to schedules_path
  end

  def status
    @schedule = Schedule.find(params[:schedule_id])
    case @schedule.schedule_status
    when '解決済質問'
      @schedule.update(schedule_status: 1)
    when '質問中'
      @schedule.update(schedule_status: 2)
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :start_time, :end_time,
                                     :content, :question, :schedule_status)
  end

  # スケジュールに質問が記載されていた場合ステータスを変更する
  def question_status_check(schedule)
    return if schedule.question.blank?

    schedule.update(schedule_status: 1) if schedule.schedule_status == '未質問'
  end

  # 編集ページに管理者、投稿者以外の人がアクセスした場合、スケジュール一覧に飛ばす
  def check_admin_or_current_employee
    @schedule = Schedule.find(params[:id])
    return if @schedule.employee_id == current_employee.id || current_employee.admin

    redirect_to schedules_path, flash: { danger: 'アクセスしたページには権限が無いため閲覧できません。' }
  end
end
