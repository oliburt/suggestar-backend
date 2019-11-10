class Api::V1::ReviewsController < ApplicationController
  
  def create
    if @current_user
      review = Review.create(review_params)
      if review.valid?
        render json: review
      else
        render json: { errors: review.errors.full_messages }, status: :not_accepted
      end
    else
      render json: { error: "user not valid"}
    end
  end

  def update
    byebug
    if @current_user
      review = Review.find(params[:id])
      review.update(review_params)
      if review.valid?
        render json: review
      else
        render json: { errors: review.errors.full_messages }, status: :not_accepted
      end
    else
      render json: { error: "user not valid"}
    end
  end

  def destroy
    if @current_user
      review = Review.find(params[:id])
      if review.destroy
        render json: review
      else
        render json: { errors: review.errors.full_messages }, status: :not_accepted
      end
    else
      render json: { error: "user not valid"}
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :user_id, :venue_id)
  end
end
