class Public::ScheduleFavoritesController < ApplicationController
  before_action :check_employee_signed

  def create
    @schedule = Schedule.find(params[:schedule_id])
    schedule_favorite = current_employee.schedule_favorites.new(schedule_id: @schedule.id)
    schedule_favorite.save
  end

  def destroy
    @schedule = Schedule.find(params[:schedule_id])
    schedule_favorite = current_employee.schedule_favorites.find_by(schedule_id: @schedule.id)
    schedule_favorite.destroy
  end
end