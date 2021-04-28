class Public::GroupRelationshipsController < ApplicationController
  before_action :check_employee_signed
  before_action :check_current_employee
  before_action :sidebar_questions_count
  before_action :sidebar_replies_count
  def new
    @group = Group.includes(:group_relationships)
                  .find(params[:group_id])
    @employees = Employee.where(company_id: current_employee.company_id)
                         .where.not(id: current_employee.id)
                         .page(params[:page]).per(10)
  end

  def create
    GroupRelationship.create(employee_id: params[:employee_id], group_id: params[:group_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    GroupRelationship.find_by(employee_id: params[:employee_id], group_id: params[:group_id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def check_current_employee
    @group = Group.find(params[:group_id])
    return if @group.employee_id == current_employee.id

    redirect_to schedules_path, flash: { danger: 'アクセスしたページには権限が無いため閲覧できません。' }
  end
end
