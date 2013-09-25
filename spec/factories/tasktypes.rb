# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tasktype do
    tasktype "MyString"
    datecreated "2012-09-11"
    organization_id 1
    projects_count 1
  end
end
