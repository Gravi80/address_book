require 'spec_helper'

describe "people/new.html.erb" do
  before(:each) do
    @person = FactoryGirl.build(:person)
    render
  end

  it 'has a form posting to /people' do
    assign(:person, @person)
    assert_select "form", :action => new_person_path, :method => "post"
  end

end
