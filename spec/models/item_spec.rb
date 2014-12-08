require 'spec_helper'

describe Item do
  subject { FactoryGirl.build(:item) }

  %w(name price).each do |attr|
    specify "requires #{attr}" do
      subject.send("#{attr}=",nil)
      should_not be_valid
      subject.errors_on(attr).should_not be_nil
    end
  end

  context "Popularity ranking" do
    before do
      # create items 3 records
      #inject has an empty array, it evaluates "{ |res,i| res << FactoryGirl.create(:item) }" block every time through
      #res starts with a blank array, on each loop i append one factory item into it
      #the final output of this is Array of items
      @items = 3.times.inject([]) { |res,i| res << FactoryGirl.create(:item) }

      # create order items records with 2 * Item0, 5 * Item1, 1 * Item2
      @orders = 2.times.inject([]) { |res,i| res << FactoryGirl.create(:order, :items => [@items[0]])} +
          5.times.inject([]) { |res,i| res << FactoryGirl.create(:order, :items => [@items[1]])} +
          1.times.inject([]) { |res,i| res << FactoryGirl.create(:order, :items => [@items[2]])}
      Item.count.should == 3
      OrderItem.count.should == 8
    end

    it 'returns items ranked by frequency of appearance in orders' do
      Item.by_popularity.should == [@items[1], @items[0], @items[2]]
    end
  end

end
