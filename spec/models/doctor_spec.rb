require 'rails_helper'

RSpec.describe Doctor, type: :model do
  
  it "has valid factory" do
    expect( FactoryGirl.create(:doctor) ).to be_valid
  end

  it "is not valid without a name" do
    expect( FactoryGirl.build(:doctor, name: nil) ).to_not be_valid
  end
end
