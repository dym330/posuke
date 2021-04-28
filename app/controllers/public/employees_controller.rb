class Public::EmployeesController < ApplicationController
  before_action :check_employee_signed
  before_action :check_admin_employee_signed, only: [:new]
  before_action :check_admin_or_current_employee_signed, only: [:edit, :password]
  before_action :sidebar_questions_count
  before_action :sidebar_replies_count

  def show
    @employee = Employee.find(params[:id])
  end

  def edit; end

  def password; end

  def update
    @employee = Employee.find(params[:id])
    check_absence_of_admin and return
    if current_employee.admin ? @employee.update(admin_employee_params) : @employee.update(employee_params)
      redirect_to employee_path(@employee), flash: { success: '従業員の更新に成功しました。' }
    else
      render 'edit'
    end
  end

  def update_password
    @employee = Employee.find(params[:employee_id])
    check_current_password and return
    if @employee.update(employee_params)
      flash_message_in_password_blank_or_not
      redirect_to employee_path(@employee)
    else
      render 'password'
    end
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(admin_employee_params)
    @employee.company_id = current_employee.company_id
    if @employee.save
      redirect_to employee_path(@employee), flash: { success: '従業員の新規登録に成功しました。' }
    else
      render 'new'
    end
  end

  def guest_admin_change
    employee = Employee.find_by(email: 'guest@guest.com')
    employee.update(admin: !employee.admin)
    redirect_to edit_employee_path(employee)
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

  # ログイン従業員にadmin権限がない場合、ホームに返す
  def check_admin_employee_signed
    return if current_employee.admin == true

    redirect_to schedules_path, flash: { danger: 'アクセスしたページには権限が無いため閲覧できません。' }
  end

  # ログイン従業員にadmin権限が無い、もしくは自身ではない場合、ホームに返す
  def check_admin_or_current_employee_signed
    employee_id = params[:id] || params[:employee_id]
    @employee = Employee.find(employee_id)
    return if current_employee.admin == true || @employee == current_employee

    redirect_to schedules_path, flash: { danger: 'アクセスしたページには権限が無いため閲覧できません。' }
  end

  # 引数が所属している企業に、admin権限を持つ従業員が何人いるか
  def admin_count(employee)
    company = employee.company
    admin_array = company.employees.pluck(:admin)
    admin_true_array = admin_array.select { |admin| admin == true }
    admin_true_array.length
  end

  # 企業内に一人しかadmin権限を持っていない状況で、自身のadmin権限をfalseにすることを許可しない
  def check_absence_of_admin
    return unless params[:employee][:admin] == 'false' && current_employee == @employee && admin_count(@employee) == 1

    redirect_to edit_employee_path(@employee), flash: { danger: '管理権限を持つ人は最低1人以上必要です。' }
  end

  # 現在のパスワードと一致しているかの確認
  def check_current_password
    return if @employee.authenticate(params[:employee][:current_password])

    @employee.errors.add(:current_password, 'が違います')
    render 'password'
  end

  # パスワードが空白かどうかでフラッシュの内容を変更する
  def flash_message_in_password_blank_or_not
    if params[:employee][:password].blank?
      flash[:danger] = 'パスワードが空白であったため更新はされませんでした。'
    else
      flash[:success] = 'パスワードの更新に成功しました。'
    end
  end
end
