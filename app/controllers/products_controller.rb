include CloudinaryHelper

class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    if session[:user_id]
      @currentUser = User.find(session[:user_id])
    end
    @product = Product.find params[:id]
    @reviews = @product.reviews.order(created_at: :desc)
  end

end
