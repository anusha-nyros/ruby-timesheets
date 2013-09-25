# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    email "MyString"
    first_name "MyString"
    last_name "MyString"
    message "MyText"
  end
end
