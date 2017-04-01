require 'ffaker'

FactoryGirl.define do
  factory :review do
    doctor FactoryGirl.build(:doctor)
    description FFaker::Lorem.sentence
    ratings { rand(1..5) }
  end
end
