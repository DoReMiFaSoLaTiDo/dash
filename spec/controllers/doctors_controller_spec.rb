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

      it "returns errors" do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:first_name]).to include "can't be blank"
      end
    end
  end

  describe "PUT/PATCH #update" do

    context "update with valid attributes" do
      before(:each) do
        @doctor = FactoryGirl.create(:doctor)
        patch :update, { id: @doctor.id, doctor: { last_name: "Stefanik007" } }, format: :json
      end

      it "returns updated doctor details" do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:name]).to include "Stefanik007"
      end

      it "returns response status 200" do
        expect(response.status).to eql 200
      end
    end

    context "update with invalid attributes" do
      before(:each) do
        @doctor = FactoryGirl.create(:doctor)
        patch :update, { id: @doctor.id, doctor: { last_name: "" } }, format: :json
      end

      it "returns errors" do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:last_name]).to include "can't be blank"
      end

      it "returns response error status 422" do
        expect(response.status).to eql 422
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @doctor = FactoryGirl.create(:doctor)
      delete :destroy, { id: @doctor.id }, format: :json
    end

    it "returns response success status 204" do
      expect(response.status).to eql 204
    end
  end
end
