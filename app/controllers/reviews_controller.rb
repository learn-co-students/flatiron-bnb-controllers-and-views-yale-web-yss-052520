class ReviewsController < ApplicationController
  before_action :find_review, only: [:edit, :update]
  def new()
    @review = Review.new
  end 

  def create()
    @review = Review.new(review_params)
    validate(new_review_path)
  end

  def edit
  end

  def update()
    @review.update(review_params)
    validate(edit_review_path)
  end

  private 

  def review_params
    params.require(:review).permit(:check_in, :check_out, :listing_id, :guest_id)
  end

  def find_review()
      @review = Review.find(params[:id])
  end

  def validate(valid_path = review_path(@review), error_path)
      if @review.valid?
          @review.save
          redirect_to valid_path
      else
          flash[:errors] = @review.errors.full_messages
          redirect_to error_path
      end
  end
end
