class Public::GroupRelationshipsController < ApplicationController
  before_action :sidebar_counts
  def new
    @group = Group.find(params[:group_id])
    @employees = Employee.where(company_id: current_employee.company_id).where.not(id: current_employee.id)
  end

  def create
    GroupRelationship.create(employee_id: params[:employee_id], group_id: params[:group_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    GroupRelationship.find_by(employee_id: params[:employee_id], group_id: params[:group_id]).destroy
    redirect_back(fallback_location: root_path)
  end
end