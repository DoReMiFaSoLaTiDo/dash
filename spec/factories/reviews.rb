require 'ffaker'

FactoryGirl.define do
  factory :review do
    doctor FactoryGirl.build(:doctor)
    description "Awesome"
  end
end
