FactoryGirl.define do
  factory :pay_period do
    pay_start "2012-03-12"
    pay_end "2012-03-18"
    active true
    pay_day  "2012-03-18"
    association :organization
  end
end