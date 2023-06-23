class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact, current_end_user).deliver
      redirect_to contact_thanks_path(current_end_user), notice: "お問い合わせ内容を送信しました。"
    else
      flash[:alert] = "お問い合わせの送信に失敗しました。"
      render :new
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end

end