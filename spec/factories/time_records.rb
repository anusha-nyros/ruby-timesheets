FactoryGirl.define do
  factory :time_record do
    activity_date "2012-03-12"
    description "Activity description"
    total_hours 2.5
    association :user
    association :pay_period
  end
end