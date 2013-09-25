# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
    invoice "MyString"
    date "2013-08-05"
    client "MyString"
    reference "MyString"
    amount 1
    paid 1
    balance "MyString"
    last_payment "2013-08-05"
    days_old "MyString"
    aging "MyString"
    user_id 1
    organization_id 1
  end
end
