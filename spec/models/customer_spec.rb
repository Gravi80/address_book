require 'spec_helper'

describe Customer do
  it 'is a Person' do
    should be_kind_of(Person)
  end

  it 'has orders' do
    should respond_to(:orders)
  end

  context "Finders" do

    before do
      @order = FactoryGirl.create(:order)
    end

    it 'retrieves orders' do
      @order.customer.orders.should == [@order]
    end

    it "finds a customer's most recent order" do
      customer = FactoryGirl.create(:customer)
      order1 = FactoryGirl.create(:order, :customer => customer, :created_at => 10.days.ago)
      order2 = FactoryGirl.create(:order, :customer => customer, :created_at => 1.day.ago)
      customer.orders.most_recent.should == order2
    end

  end
end
