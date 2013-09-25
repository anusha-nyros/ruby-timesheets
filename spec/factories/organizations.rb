# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name "My Organization"
    account_type "timesheet"
    users_count 0
  end
end
