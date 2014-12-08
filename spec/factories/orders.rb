FactoryGirl.define do
  factory :order do
    association :customer
    items { |i| [i.association(:item), i.association(:item)]}
  end
end