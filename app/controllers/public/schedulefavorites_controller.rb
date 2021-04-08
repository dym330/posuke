class Public::SchedulefavoritesController < ApplicationController

  def create
    schedule = Schedule.find(params[:schedule_id])
    schedule_favorite = current_employee.schedule_favorites.new(schedule_id: schedule.id)
    schedule_favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    schedule = Schedule.find(params[:schedule_id])
    schedule_favorite = current_employee.schedule_favorites.find_by(schedule_id: schedule.id)
    schedule_favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
