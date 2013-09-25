# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    vendor "MyString"
    exp_description "MyText"
    paymethod "MyString"
    date "MyString"
    expense_id 1
    user_id 1
  end
end
