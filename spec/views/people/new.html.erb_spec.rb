require 'spec_helper'

describe "people/new.html.erb" do
  before(:each) do
    @person = FactoryGirl.build(:person)
    @person.addresses.build
    render
  end

  it 'has a form posting to /people' do
    assign(:person, @person)
    assert_select "form", :action => new_person_path, :method => "post"
  end

  %w(street city zip state).each do |attr|
    it "has an address field for #{attr}" do
      assert_select("input[name*=#{attr}]")
    end
  end

end
