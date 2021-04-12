class Public::ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_when_admin_reply(@contact).deliver_now
      flash[:success] = '問い合わせ内容を弊社担当へ送信いたしました。<br>担当よりご連絡致します。'
      redirect_to root_url
    else
      render template: 'public/homes/top'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:company_name, :responsible_name, :email, :phone_number,
                                    :message)
  end
end
