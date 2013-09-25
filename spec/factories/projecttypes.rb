# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :projecttype do
    projecttype "MyString"
    usage "MyString"
    organization_id 1
  end
end
