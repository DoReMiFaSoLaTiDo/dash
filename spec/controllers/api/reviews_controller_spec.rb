require 'rails_helper'

describe Api::ReviewsController do
  before(:each) { request.headers['Accept'] = "application #{Mime::JSON}"}
  before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }

  describe "GET #show" do
    before(:each) do
      @doctor = FactoryGirl.create(:doctor)
      @review = FactoryGirl.create(:review, doctor: @doctor)
      get :show, { doctor_id: @doctor, id: @review.id }
    end

    it "returns success status code" do
      result = parsed_response
      expect(response.status).to eql 200
    end

    it "returns review description" do
      result = parsed_response
      expect(result[:description]).to eql @review.description
    end

    it "includes the associated doctor" do
      result = parsed_response
      expect(result).to have_key :doctor
      expect(result[:doctor][:name]).to eql @doctor.name
    end

    it "doesn't contain ratings data" do
      result = parsed_response
      expect(result[:ratings]).to be_nil
    end
  end

  describe "GET #index" do
    before(:each) do
      @doctor = FactoryGirl.create(:doctor)
      5.times { FactoryGirl.create(:review, doctor: @doctor) }
      get :index
    end

    it "returns success status code" do
      expect(response.status).to eql 200
    end

    it "returns 5 records" do
      result = parsed_response
      # raise result.inspect
      expect(result.size).to eql(5)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @doctor = FactoryGirl.create(:doctor)
        @review_attribs = FactoryGirl.attributes_for :review
        @review_attribs.tap { |att| att[:doctor_id] = @doctor.id }
        post :create, { doctor_id: @doctor.id, review: @review_attribs }
      end

      it "returns success code 200" do
        result = parsed_response
        expect(response.status).to eql 200
      end

      it "returns details of newly created record" do
        result = parsed_response
        expect(result[:description]).to eql Review.new(@review_attribs).description
      end
    end

    context "with invalid attributes" do
      before(:each) do
        @doctor = FactoryGirl.create(:doctor)
        @review_attribs = FactoryGirl.attributes_for :fake_review
        post :create, { doctor_id: @doctor.id, review: @review_attribs }
      end

      it "returns error code 422" do
        expect(response.status).to eql 422
      end

      it "returns errors" do
        result = parsed_response
        expect(result[:description]).to include "can't be blank"
        expect(result[:id]).to be_nil
      end
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @doctor = FactoryGirl.create :doctor
      @review = FactoryGirl.create :review, doctor: @doctor
    end

    context "with valid update attributes" do
      before(:each) do
        patch :update, { doctor_id: @doctor.id, id: @review.id,
          review: { description: "Awesome doc" } }
      end

      it "returns success code 200" do
        expect(response.status).to eql 200
      end

      it "returns updated review" do
        result = parsed_response
        expect(result[:id]).to eql @review.id
        expect(result[:description]).to eql "Awesome doc"
      end
    end

    context "with invalid update attributes" do
      before(:each) do
        patch :update, { doctor_id: @doctor.id, id: @review.id,
          review: { description: nil } }
      end

      it "returns error code 422" do
        expect(response.status).to eql 422
      end

      it "returns the error" do
        result = parsed_response
        expect(result[:description]).to include "can't be blank"
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @doctor = FactoryGirl.create :doctor
      @review = FactoryGirl.create :review, doctor: @doctor
      delete :destroy, { doctor_id: @doctor.id, id: @review.id }
    end

    it "returns success status code 204" do
      expect(response.status).to eql 204
    end
  end
end
