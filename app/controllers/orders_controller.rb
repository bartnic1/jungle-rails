class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def create
    charge = perform_stripe_charge
    orderArray = create_order(charge)
    order = orderArray[0]
    orderItems = orderArray[1]
# Want to find the product names that were just ordered, and decrement their quantity by 1

    if order.valid?
      # Update products
      # For now this will do...but in the future would be nice to find way to load all products at once
      # into an array, rather than accessing the database for each item!

      # orderItems.each do |itemArray|
      #   @product = Product.find(itemArray[0])
      #   @product.quantity = @product.quantity - itemArray[1]
      # end

      order.save
      # @products = Product.joins("inner join line_items on products.id = line_items.product_id").where("line_items.order_id = #{order.id}")
      # @products.each do |product|
      #   product.quantity
      # end
      empty_cart!
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
