class Admin::CompaniesController < ApplicationController
  before_action :authenticate_admin!
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    #従業員の中に同じEメールが無いかチェックし、いたら登録をせずフォームに返す
    if Employee.find_by(email: @company.email)
      @company.errors.add(:email, "はすでに存在します")
      return render 'new'
    end
    @company.usage_status = true
    if @company.save
      @company.employee_admin_create
      flash[:success] = '登録完了しました。'
      redirect_to admin_companies_path
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
      flash[:success] = '登録完了しました。'
      redirect_to admin_company_path(@company)
    else
      render 'edit'
    end
  end

  private

  def company_params
    params.require(:company).permit(:company_name, :responsible_name, :postcode,
                                    :address, :email, :phone_number, :usage_status)
  end

end
