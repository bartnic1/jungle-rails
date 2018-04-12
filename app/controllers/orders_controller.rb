class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    if session[:user_id]
      @currentUser = User.find(session[:user_id])

    # The usermailer below only works for localserver (though, even then it can't really send an e-mail
    # from within the vagrant machine. You have to open sent emails using letteropener)

      # NOTE: MUST BE SIGNED IN FOR THIS TO WORK!!

      UserMailer.thank_you_email(@currentUser, @order).deliver_later

      # New format from rails guide:
      # UserMailer.with(user: @currentUser, order: @order).thank_you_email.deliver_later

    end
  end

  def create
    charge = perform_stripe_charge
    orderArray = create_order(charge)
    order = orderArray[0]
    orderItems = orderArray[1]

    if order.valid?

      orderItems.each do |itemArray|
        @product = Product.find(itemArray[0])
        @product.quantity = @product.quantity - itemArray[1]
        @product.save
      end

      order.save
      empty_cart!
      # order path = /orders/:id
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_total, # in cents
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    productArray = []
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_total,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )
    cart.each do |product_id, details|
      if product = Product.find_by(id: product_id)
        quantity = details['quantity'].to_i
        order.line_items.new(
          # Does product below automatically select product_id?
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
        # product.quantity = product.quantity - quantity
        productArray.push([product, quantity])
      end
    end
    order.save!
    [order, productArray]
  end

  # returns total in cents not dollars (stripe uses cents as well)
  def cart_total
    total = 0
    cart.each do |product_id, details|
      if p = Product.find_by(id: product_id)
        total += p.price_cents * details['quantity'].to_i
      end
    end
    total
  end

end
