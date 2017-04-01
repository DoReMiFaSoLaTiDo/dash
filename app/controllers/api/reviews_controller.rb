class Api::ReviewsController < ApplicationController
  before_filter :set_review, only: [:show, :update, :delete]

  def show
    render json: @review
  end

  def index
    render json: Review.all
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end
end
