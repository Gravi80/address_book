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

  it 'can make a person from factory' do
    @person.should_not be_nil
    @person.should be_kind_of(Person)
  end

  it 'should find people by partial name matches'do
    ravi=FactoryGirl.create(:person)
    ram_lal=FactoryGirl.create(:person,:first_name=>"Ram",:last_name=>"Lal")
    lalo_ram=FactoryGirl.create(:person,:first_name=>"Lalo",:last_name=>"Ram")
    Person.all.should == [ravi,ram_lal,lalo_ram]
    Person.find_by_names_starting_with("Ram").should == [lalo_ram,ram_lal]
  end

  it { should have_many(:addresses).class_name(Address) }

  it 'should save the multiple address of a person' do
    delhi=FactoryGirl.create(:address)
    mumbai=FactoryGirl.create(:address,:city=>"Mumbai")
    @person.add_address delhi
    @person.add_address mumbai
    @person.save
    delhi.person.should eql @person
    mumbai.person.should eql @person
    @person.addresses.size.should eql 2
  end


  describe "Nested Attributes" do

    it 'should create an address record from attributes' do
      lambda{
        lambda{
          Person.create(:first_name=>"Ravi",
                        :last_name=>"Sharma",
                        :addresses_attributes => [{:city => "San Francisco",
                                                   :street => "123 Main St",
                                                   :zip => "94103",
                                                   :state => "CA"}]
          )
        }.should change(Person,:count).by(1)
      }.should change(Address,:count).by(1)
    end
    
      context "creating" do
        subject { Person.new(:first_name => "Ravi", :last_name => "Sharma") }
        it 'creates an address' do
          lambda {
            subject.addresses = [Address.new({:city => "San Francisco", :street => "123 Main St", :zip =>94103})]
            subject.save!
          }.should change {subject.addresses(true).count}.from(0).to(1)
        end
      end
  end



  describe "Associations" do
    it 'has message' do
      Person.new.should respond_to(:messages)
    end

    it 'can retrieve messages' do
      p = FactoryGirl.build(:person)
      p.messages.should be_empty
    end

  end

end
