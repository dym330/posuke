class Public::SchedulesController < ApplicationController
  def index
    @schedule = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.employee_id = current_employee.id
    if @schedule.save
      redirect_to schedules_path, success: '予定を登録しました'
    else
      render 'new'
    end
  end

  def show
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :start_time, :end_time,
                                    :content, :question, :schedule_status)
  end
end
