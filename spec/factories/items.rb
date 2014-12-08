FactoryGirl.define do
  factory :item do
    sequence(:name) {|n| "Product ##{n}"} #  it evaluates "{|n| "Product ##{n}"}" block every time factory creates a
                                          #  new item and it sticks a new number to it, sequence gives
                                          #  incrementing number every time
    sequence(:price) {|n| 100 + n}
  end

end
