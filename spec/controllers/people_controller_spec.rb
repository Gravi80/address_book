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
      assigns[:person].should_not be_nil
      assigns[:person].should be_a_kind_of(Person)
      assigns[:person].should be_new_record

    end

  end

  describe "POST 'create'" do
    before do
      # you can check parameters in form
      @post_parameters={ :person => {
                                      :first_name=>"Ravi",
                                      :last_name=>"Sharma",
                                      :addresses_attributes => [{:city => "San Francisco",
                                                                 :street => "123 Main St",
                                                                 :zip => "94103",
                                                                 :state => "CA"}]
      }}
    end

    it 'should assign a @person variable' do
      post :create,@post_parameters
      assigns[:person].should_not be_nil
      assigns[:person].should be_a_kind_of(Person)
    end

    context "when successful" do

      it 'redirects to index'do
        post :create,@post_parameters
        response.should redirect_to(people_path)
      end
      it 'creates a Person record' do
        lambda{
          lambda{
            post :create,@post_parameters
          }.should change(Person,:count).by(1)
        }.should change(Address,:count).by(1)

      end

    end

    context "When failure" do
      before do
        @post_parameters={ :person => {:first_name=>'',
                                       :last_name=>"Sharma"}
        }
      end
      it 're-renders the "new" template'do
        post  :create,@post_parameters
        response.should render_template('new')
      end
      it 'does not creates a Person record' do
        lambda{
          post :create,@post_parameters
        }.should_not change(Person,:count)
      end
    end
    context "when using a verb other than POST" do
      it 'rejects the request' do
          # controller.should_not_receive(:create)
          # get :create
      end
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

end
