class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def thank_you_email(user, order)
    @order = order
    @user = user
    @url  = 'http://example.com/login'

    mail(to: @user.email, subject: 'Order #' + @order.id.to_s + ' has been placed. Thank you!')

    # Old way:
    # mail(to: "bartnic1@gmail.com", subject: 'Order #' + @order.id.to_s + ' has been placed. Thank you!')
    # Uses UserMailer.with(user: @currentUser, order: @order).thank_you_email.deliver_later

  end
end