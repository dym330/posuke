class Admin::CompaniesController < ApplicationController
  before_action :authenticate_admin!
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    check_duplicate_email_in_employees and return
    if @company.save
      @company.employee_admin_create
      redirect_to admin_companies_path, flash: { success: '登録完了しました。' }
    else
      render 'new'
    end
  end

  def index
    @companys = Company.includes(:employees).all.page(params[:page]).per(10)
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      redirect_to admin_company_path(@company), flash: { success: '登録完了しました。' }
    else
      render 'edit'
    end
  end

  private

  def company_params
    params.require(:company).permit(:company_name, :responsible_name, :postcode,
                                    :address, :email, :phone_number, :usage_status)
  end

  # 全従業員に今回登録する企業のEメールと同じEメールが無いか確認
  def check_duplicate_email_in_employees
    return unless Employee.find_by(email: @company.email)

    @company.errors.add(:email, 'はすでに存在します')
    render 'new'
  end
end
