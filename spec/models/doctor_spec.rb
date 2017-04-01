require 'rails_helper'

describe Doctor do
  before {@doctor = FactoryGirl.create(:doctor) }

  subject{ @doctor }

  it { should be_valid }
  it { should respond_to :name }

  it "is not valid without a name" do
    expect( FactoryGirl.build(:doctor, name: nil) ).to_not be_valid
  end
  
end
