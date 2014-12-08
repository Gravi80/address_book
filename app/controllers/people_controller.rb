class PeopleController < ApplicationController
  def index
    @people=Person.all
  end

  def show
  end

  def new
    @person=Person.new
  end

  def edit
  end
end
