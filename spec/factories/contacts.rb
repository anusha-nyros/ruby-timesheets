# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    contact_type "contact"
    contact "Contact name"
    company "company name"
    email "email@email.com"
    chat_tool "Chat tools"
    active true
    notes "Notes "
    association :user
    association :organization
  end
end
