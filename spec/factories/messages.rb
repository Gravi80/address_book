FactoryGirl.define do
  factory :message do
    association :sender,:factory => :person
    association :recipient,:factory => :person
    subject "Hello World"
    body "Bye World"
  end

  factory :read_message, :parent => :message do
    read_at Time.now
  end

end
