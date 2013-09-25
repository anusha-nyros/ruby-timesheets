# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title "Project Title"
    project_type "Project type"
    description "Project Description"
    amount "Project Amount"
    association :organization
    supplier { Factory(:contact) }
    notes "Project notes"
  end
end
