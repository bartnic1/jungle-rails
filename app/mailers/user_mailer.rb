class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def thank_you_email
    @order = params[:order]
    @user = params[:user]
    @url  = 'http://example.com/login'
    # Formerly: @user.email
    mail(to: "bartnic1@gmail.com", subject: 'Order #' + @order.id.to_s + ' has been placed. Thank you!')
  end
end
