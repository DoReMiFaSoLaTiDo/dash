class Api::ReviewsController < ApplicationController
  before_filter :set_review, only: [:show, :update, :delete]

  def show
    render json: @review
  end

  def index
    render json: Review.all
  end

  def create
    @review = Review.new(approved_params)

    if @review.save
      render json: @review, status: 200
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def update
    if @review.update(approved_params)
      render json: @review, status: 200
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end


  private

    def set_review
      @review = Review.find(params[:id])
    end

    def approved_params
      params.require(:review).permit(:description, :ratings, :reviewer, :doctor_id)
    end
end
