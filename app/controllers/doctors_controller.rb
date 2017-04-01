class DoctorsController < ApplicationController
  before_filter :set_doctor, only: [:edit, :show]

  def index
    @doctors = Doctor.all#includes(:reviews).all
    render json: @doctors
  end

  def show
    render json: @doctor
    #render json: @doctor.as_json
  end

  def create
    @doctor = Doctor.new(approved_params)

    if @doctor.save
      render json: @doctor, status: 200
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end

  end


  private
    def approved_params
      params.require(:doctor).permit(:first_name, :last_name, :title)
    end

    def set_doctor
      @doctor = Doctor.find(params[:id])#.includes(:reviews)
    end

end
