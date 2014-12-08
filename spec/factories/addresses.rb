FactoryGirl.define do
  factory :address, class: Address do
    street "First Street"
    city "Delhi"
    zip 110098
    association :person
    state "MP"
  end

end
