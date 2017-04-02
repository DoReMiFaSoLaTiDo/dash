class Api::ReviewsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  before_filter :set_review, only: [:show, :update, :destroy]
  before_filter :set_doctor, only: [:create]

  def show
    render json: @review
  end

  def index
    render json: Review.all
  end

  def create
    @review = @doctor.reviews.new(approved_params)

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

  def destroy
    @review.destroy
    head 204
  end


  private
    def set_review
      @review = Review.find(params[:id])
    end

    def approved_params
      params.require(:review).permit(:description, :ratings, :reviewer, :doctor_id)
    end

    def set_doctor
      @doctor = Doctor.find(params[:doctor_id])
    end

    def render_404
      render json: { error: "Record Not Found", status: 404 }
    end
end
