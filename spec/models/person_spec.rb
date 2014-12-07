require 'spec_helper'

describe Person do
  before(:each) do
    @person = FactoryGirl.build(:person)
  end

  it "should save a person" do
    lambda{
      @person.save
    }.should change{Person.count}.by(1)
  end

  # it 'must have first name' do
  #   lambda{
  #     Person.create(:first_name=>'',:last_name=>'sharma')
  #   }.should_not change(Person,:count)
  # end

  # We don't have to go to DB to save it bcz rails intercepts un invalid objects while saving,
  # Saving it implicilty tests that it is valid
  # Before Rails saves anything it runs validations , by calling valid? method

  it 'must have first_name' do
    person=Person.new(:middle_name=>"Ramesh",:last_name=>"Tendulkar")
    person.should_not be_valid
    person.errors_on(:first_name).should_not be_nil  #i want to make sure error is on right attribute
  end

  it 'must have a first and last name' do
    person=Person.new
    person.should_not be_valid       #calls person.valid?
  end

  it 'must give a full name' do
    joe = Person.new({:first_name=>"Joe",:last_name=>"John"})
    sachin=Person.new({:first_name=>"Sachin",:middle_name=>"Ramesh",:last_name=>"Tendulkar"})
    joe.full_name.should eql "Joe John"
    sachin.full_name.should eql "Sachin Ramesh Tendulkar"
  end

  it 'can have optional middle name' do
    sachin=Person.new({:first_name=>"Sachin",:middle_name=>"Ramesh",:last_name=>"Tendulkar"})
    ravi=Person.new({:first_name=>"Ravi",:last_name=>"Sharma"})
    sachin.should be_valid
    ravi.should be_valid
  end


end
