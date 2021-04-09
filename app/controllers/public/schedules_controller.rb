class Public::SchedulesController < ApplicationController
  before_action :sidebar_counts, only: [:show, :edit, :new, :index]
  def index
    @company = Company.find(current_employee.company.id)
    @schedules = Schedule.where(employee_id: @company.employees.ids).order(created_at: :DESC)
  end

  def new
    @schedule = Schedule.new
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      question_status_check(@schedule)
      flash[:success] = '予定を更新しました'
      redirect_to schedule_path(@schedule)
    else
      render 'edit'
    end
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.employee_id = current_employee.id
    if @schedule.save
      flash[:success] = '予定を登録しました'
      redirect_to schedules_path
    else
      render 'new'
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
    @scheduleComment = ScheduleComment.new
    if @schedule.comment_status == true && current_employee.id == @schedule.employee_id
      @schedule.update(comment_status: false)
    end
  end

  def destroy
    Schedule.find(params[:id]).destroy
    flash[:success] = '予定を削除しました'
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

  #スケジュールに質問が記載されていた場合ステータスを変更する
  def question_status_check(schedule)
    unless schedule.question.blank?
      schedule.update(schedule_status: 1) if schedule.schedule_status == '未質問'
    end
  end
  
end
