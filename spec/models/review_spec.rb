require 'rails_helper'
require 'ffaker'

RSpec.describe Review, type: :model do
  before(:each) do
    @doctor = Doctor.create!(name: FFaker::Name.name )
  end
  it "has valid factory" do
    expect( FactoryGirl.create(:review, doctor: @doctor) ).to be_valid
  end

  it "is not valid without a description" do
    expect( FactoryGirl.build(:review, doctor: @doctor, description: nil) ).to_not be_valid

  end
end
