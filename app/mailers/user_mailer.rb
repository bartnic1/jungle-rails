class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def thank_you_email
    @order = params[:order]
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Order #' + @order.id.to_s + ' has been placed. Thank you!')
  end
end
