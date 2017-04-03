class Api::ReviewsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  before_filter :set_review, only: [:show, :update, :destroy]
  before_filter :set_doctor, only: [:index, :create, :update, :destroy]

  def show
    render json: @review
  end

  def index
    render json: @doctor.reviews.all
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
    raise ActiveRecord::RecordNotFound unless @doctor.reviews.include? @review
    if @review.update(approved_params)
      render json: @review, status: 200
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @doctor.reviews.include? @review
      @review.destroy
      head 204
    else
      raise ActiveRecord::RecordNotFound
    end
  end


  private
    def set_review
      @review = Review.find(params[:id])
    end

    def approved_params
      params.require(:review).permit(:id, :description, :ratings, :reviewer, :doctor_id)
    end

    def set_doctor
      @doctor = Doctor.find(params[:doctor_id])
    end

    def render_404
      render json: { error: "Record Not Found", status: 404 }
    end
end
