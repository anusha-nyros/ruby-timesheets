# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link_account do
    source "MyString"
    target "MyString"
    source_id 1
    target_id 1
    source_admin_id 1
    target_admin_id 1
    accept "MyString"
    request "MyString"
    ignor false
    remove false
  end
end
