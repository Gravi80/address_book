require 'spec_helper'

describe Message do

  describe "Validations" do
    before do
      @message=Message.new
      @message.should_not be_valid
    end

    %w(sender recipient subject).each do |attribute|
      it "must have #{attribute}" do
        @message.errors_on(attribute).should_not be_blank
      end
    end
  end

  describe "Association" do
    it 'belongs to a sender' do
      Message.new.should respond_to(:sender)
      should belong_to(:sender).class_name(Person) # testing same thing
    end

    it 'belongs to a recipient' do
      Message.new.should respond_to(:recipient)
      should belong_to(:recipient).class_name(Person) # testing same thing
    end

    it 'can retrieve a sender and that is a person object' do
        msg=FactoryGirl.build(:message)
        msg.sender.should_not be_nil
        msg.sender.should be_a_kind_of(Person)
    end

    it 'can retrieve new messages' do
      recipient = FactoryGirl.create(:person)
      msg_new = FactoryGirl.create(:message, :recipient => recipient)
      msg_read = FactoryGirl.create(:read_message, :recipient => recipient)

      # Verify data set is non-trivial and correct
      recipient.messages.should == [msg_read,msg_new]

      recipient.unread_messages.should == [msg_new]
    end

  end

end
