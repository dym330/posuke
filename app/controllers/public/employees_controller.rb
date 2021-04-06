class Public::EmployeesController < ApplicationController
  def show
  end

  def edit
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
end
