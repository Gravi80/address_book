require 'spec_helper'

describe PeopleController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "renders the 'index' template" do
      get :index
      response.should render_template('index')
    end

    it "assign a @people variable" do
      p=FactoryGirl.create(:person)
      get :index
      # assigns[:people] reports @people instance variable of the controller
      assigns[:people].should == [p]
    end

  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "should renders the 'new' template" do
      get :new
      response.should render_template('new')
    end

    it "assign a new Person object" do
      get :new

      assigns[:people].should_not be_nil
      assigns[:people].should be_a_kind_of(Person)
      assigns[:people].should be_new_record

    end

  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

end
