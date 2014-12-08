FactoryGirl.define do
  factory :order do
    association :customer
    items { |i| [i.association(:item), i.association(:item)]}
  end

  factory :order_with_1_item, :class => Order do
    association :customer
    items { |i| [i.association(:item)]}
  end
end