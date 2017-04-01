require 'rails_helper'
require 'ffaker'

RSpec.describe Review, type: :model do
  before(:each) do
    @doctor = FactoryGirl.create(:doctor) 
  end
  it "has valid factory" do
    expect( FactoryGirl.create(:review, doctor: @doctor) ).to be_valid
  end

  it "is not valid without a description" do
    expect( FactoryGirl.build(:review, doctor: @doctor, description: nil) ).to_not be_valid

  end
end
