# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account_history do
    date "2013-07-31"
    num_invoice "MyString"
    description "MyText"
    type_of_account "MyString"
    reference "MyString"
    amount "9.99"
    balance "9.99"
    statement_attachment "MyString"
    contact_id 1
    organization_id 1
    user_id 1
  end
end
