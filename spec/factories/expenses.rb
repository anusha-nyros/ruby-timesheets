# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    exp_number "MyString"
    username "MyString"
    date "2012-08-23"
    amount "9.99"
    status false
    approved_date "2012-08-23"
    organization_id 1
    user_id 1
    description "MyText"
  end
end
