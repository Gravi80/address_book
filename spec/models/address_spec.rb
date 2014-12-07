require 'spec_helper'

describe Address do

  context "Validations" do
    before do
      @addr=Address.new
      @addr.should_not be_valid
    end

    [:city,:zip,:street].each do |attribute|
      it "must have a #{attribute}" do
        @addr.errors_on(attribute).should_not be_empty
      end
    end

  end

  describe "When country is missing" do

    it 'defaults to India' do
      address=Address.new(:street=>"First Street",:city=>"Delhi",:zip=> 110098)
      address.country.should be_blank
      address.save
      address.country.should eql "India"
    end
  end

  it 'can make a address from factory' do
    address=FactoryGirl.build(:address)
    address.should_not be_nil
    address.should be_kind_of(Address)
  end

  it { should belong_to(:person).class_name(Person)}



end
