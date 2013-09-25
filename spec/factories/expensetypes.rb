# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expensetype do
    expensetype "MyString"
    usage "MyString"
    organization_id 1
  end
end
