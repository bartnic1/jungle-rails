class ReviewsController < ApplicationController

  def create
    @currentUser = User.find(session[:user_id])
    reviewHash = {:product_id => params[:product_id].to_i, :user_id => session[:user_id],
     :description => review_params['description'], :rating => review_params['rating'].to_i}
    @review = Review.new(reviewHash)
    @review.save
    redirect_to product_path(params[:product_id])
  end


  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end
end
