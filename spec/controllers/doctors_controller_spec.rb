require 'rails_helper'
require 'ffaker'

describe DoctorsController do
  before(:each) { request.headers['Accept'] = "application"}

  describe "GET #show" do
    before(:each) do
      @doctor = FactoryGirl.create(:doctor)
      get :show, id: @doctor.id, format: :json
    end

    it "returns information about doctor and associated reviews" do
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:name]).to eql @doctor.name
    end

    it "returns 200 success status" do
      expect(response.status).to eql 200
    end
  end

  describe "POST #create" do
    before(:each) do
      @doctor = FactoryGirl.attributes_for :doctor
    end

    context "with valid attributes" do
      before(:each) do
        post :create, { doctor: @doctor }, format: :json
      end

      it "returns record created" do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:name]).to eql Doctor.new(@doctor).name
      end

      it "returns response status 200" do
        expect(response.status).to eql 200
      end
    end

    context "with invalid attributes" do
      before(:each) do
        @doctor = @doctor.tap { |doc| doc[:first_name] = nil }
        post :create, { doctor: @doctor }, format: :json
      end

      it "returns response status 422" do
        expect(response.status).to eql 422
      end

      # it "returns errors" do
      #   result = JSON.parse(response.body, symbolize_names: true)
      #   raise response.inspect #expect(result).to have_key :errors
      #   expect(result[:errors][:name]).to include "can't be blank"
      # end
    end

  end
end
