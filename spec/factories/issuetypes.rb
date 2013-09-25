# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issuetype do
    issuetype "MyString"
    usage "MyString"
    organization_id 1
  end
end
