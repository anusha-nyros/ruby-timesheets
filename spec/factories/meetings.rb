# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meeting do
    meeting_number "MyString"
    meeting_date "2012-07-18"
    meeting_time "2012-07-18 11:41:58"
    meeting_location "MyString"
    subject "MyString"
    meeting_notes "MyText"
    action_items "MyText"
  end
end
