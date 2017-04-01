require 'rails_helper'
require 'ffaker'

RSpec.describe Review, type: :model do
  before(:each) do
    @review = FactoryGirl.create(:review, doctor: @doctor)
  end

  subject{ @review }
  it { should be_valid }

  context "with invalid parameters" do
    it "is not valid without a description" do
      expect( FactoryGirl.build(:review, doctor: @doctor, description: nil) ).to_not be_valid
    end

    it "is not valid with ratings greater than 5" do
      expect( FactoryGirl.build(:review, doctor: @doctor, ratings: 10) ).to_not be_valid
    end

    it "is not valid with ratings less than 1" do
      expect( FactoryGirl.build(:review, doctor: @doctor, ratings: 0) ).to_not be_valid
    end
  end

  context "with no associated doctor" do
    before(:each) do
      @doctor = FactoryGirl.create(:doctor)
      5.times {FactoryGirl.create(:review, doctor: @doctor)}
    end

    it "destroys associated review when doctor is deleted" do
      reviews = @doctor.reviews
      @doctor.destroy
      reviews.each do |review|
        expect(Review.find(review)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end


end
