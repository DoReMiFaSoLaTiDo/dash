class Api::DoctorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  before_filter :set_doctor, only: [:show, :update, :destroy ]

  def index
    @doctors = Doctor.all#includes(:reviews).all
    render json: @doctors
  end

  def show
    render json: @doctor
  end

  def create
    @doctor = Doctor.new(approved_params)

    if @doctor.save
      render json: @doctor, status: 200
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end

  end

  def update
    if @doctor.update(approved_params)
      render json: @doctor, status: 200
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @doctor.destroy
    head 204
  end

  private
    def approved_params
      params.require(:doctor).permit(:first_name, :last_name, :title)
    end

    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    def render_404
      render json: { error: "Record Not Found", status: 404 }
    end

end
