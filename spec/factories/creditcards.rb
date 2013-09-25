# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :creditcard do
    number 1
    expiryon "2012-10-04"
    organization_id 1
    user_id 1
  end
end
