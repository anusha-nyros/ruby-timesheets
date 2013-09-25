# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inv_line_item do
    reference "MyString"
    description "MyText"
    quantity "MyString"
    unit "MyString"
    amount 1
    extended "MyString"
    text_comment "MyText"
    invoice_id 1
  end
end
