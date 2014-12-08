FactoryGirl.define do
  factory :customer do
    sequence(:first_name) { |n| "Sally#{n}" }
    sequence(:last_name) { |n| "Porter#{n}" }
  end
end