require 'rails_helper'

describe Api::ReviewsController do
  before(:each) { request.headers['Accept'] = "application #{Mime::JSON}"}
  before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }

  describe "GET #show" do
    before(:each) do
      @doctor = FactoryGirl.create(:doctor)
      @review = FactoryGirl.create(:review, doctor: @doctor)
      get :show, id: @review.id
    end

    it "returns success status code" do
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
end
