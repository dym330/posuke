# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    guest_admin = Admin.find_or_create_by!(email: 'guest@guest.com') do |admin|
      admin.password = 'password'
    end
    sign_in(guest_admin)
    redirect_to admin_companies_path, flash: { success: 'ゲストユーザーとしてログインしました。' }
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
