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

  context "Loyalty search" do

    before do
      Order.delete_all
      OrderItem.delete_all
      Item.delete_all
      @order1 = FactoryGirl.create(:order)
      @customer1 = @order1.customer
      @order2 = FactoryGirl.create(:order_with_1_item, :created_at => 91.days.ago)
      @customer2 = @order2.customer
      @item1=FactoryGirl.create(:item)
      @item2=FactoryGirl.create(:item)
      @order1.order_items.create(:item=>@item1)
      @order1.order_items.create(:item=>@item2)
    end

    it 'finds customers who placed orders in the last 90 days' do
      Customer.loyal_last_90_days.should == [@customer1]
    end

    # it 'finds customers who placed orders for a total of at least 2 items' do
    #   Customer.min_2_items.should == [@customer1]
    # end

  end

end
