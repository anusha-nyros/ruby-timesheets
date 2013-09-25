# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :statusreport do
    report_number "MyString"
    report_date "2012-07-26"
    report_time "2012-07-26 12:02:50"
    send_to "MyString"
    sent_by "MyString"
    subject "MyString"
  end
end
