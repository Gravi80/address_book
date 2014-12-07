FactoryGirl.define do
  factory :address, class: Address do
    street "First Street"
    city "Delhi"
    zip 110098
    association :person_id,:factory => :person
  end

end
