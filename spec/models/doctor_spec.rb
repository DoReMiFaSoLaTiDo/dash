require 'rails_helper'

describe Doctor do
  before {@doctor = FactoryGirl.create(:doctor) }

  subject{ @doctor }

  it { should be_valid }
  it { should respond_to :name }
  it { should respond_to :first_name }
  it { should respond_to :last_name }

  it "is not valid without a first_name" do
    expect( FactoryGirl.build(:doctor, first_name: nil) ).to_not be_valid
  end

  it "is not valid without a last_name" do
    expect( FactoryGirl.build(:doctor, last_name: nil) ).to_not be_valid
  end

end
