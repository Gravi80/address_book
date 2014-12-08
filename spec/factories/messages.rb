FactoryGirl.define do
  factory :message do
    association :sender,:factory => :person
    association :recipient,:factory => :person
    subject "Hello World"
    body "Bye World"
    read_at "2014-12-08 01:06:35"
  end

end
