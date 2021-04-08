class Public::SessionsController < ApplicationController
  def new
  end

  def create
    employee = Employee.find_by(email: params[:session][:email])
    if employee && employee.authenticate(params[:session][:password])
      log_in(employee)
      redirect_to schedules_path
    else
      flash.now[:danger] = 'Eメールまたはパスワードが違います。'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
  
end
