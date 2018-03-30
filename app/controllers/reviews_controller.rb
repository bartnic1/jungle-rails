class ReviewsController < ApplicationController

  before_action :require_login

  def require_login
    unless session[:user_id]
      puts "You must be logged in to access this section"
      redirect_to root_path
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(description: review_params['description'], rating: review_params['rating'].to_i)
    @review.user_id = session[:user_id]
    @review.save
    redirect_to product_path(params[:product_id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to product_path(@review.product), notice: 'Product deleted!'
  end

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end
end
