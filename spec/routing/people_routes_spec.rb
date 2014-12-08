require 'spec_helper'

describe PeopleController do
  it 'should route /people' do
    {:get =>'/people'}.should route_to(:controller => 'people', :action =>'index')
  end

  it 'should route /people/new' do
    {:get =>'/people/new'}.should route_to(:controller => 'people', :action =>'new')
  end

  it 'should route /people with POST' do
    {:post=>'/people'}.should route_to(:controller => 'people', :action =>'create')
  end

end