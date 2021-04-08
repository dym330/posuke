class Public::EmployeesController < ApplicationController
  before_action :sidebar_counts, only: [:show, :edit, :new]

  def show
    @employee = Employee.find(params[:id])
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if (@employee.admin ? @employee.update(admin_employee_params) : @employee.update(employee_params))
      flash[:success] = "従業員の更新に成功しました"
      redirect_to employee_path(@employee)
    else
      render 'edit'
    end
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(admin_employee_params)
    @employee.company_id = 1
    if @employee.save
      flash[:success] = "従業員の新規登録に成功しました"
      redirect_to employee_path(@employee)
    else
      render 'new'
    end
  end

  private

  def admin_employee_params
    params.require(:employee).permit(:name, :email, :password, :password_confirmation,
                                :image, :department, :joining_date, :admin, :enrollment_status)
  end
  def employee_params
    params.require(:employee).permit(:name, :email, :password, :password_confirmation,
                                :image, :department, :joining_date)
  end
end
