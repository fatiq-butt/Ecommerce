class InviteMailer < ApplicationMailer
  
  def invite_created
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: "You are invited by admin")
  end  
end  
