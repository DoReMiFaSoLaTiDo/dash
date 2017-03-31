require 'ffaker'

FactoryGirl.define do
  factory :doctor do
    name {FFaker::Name.name }
  end
end
