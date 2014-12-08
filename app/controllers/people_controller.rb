class PeopleController < ApplicationController
  def index
    @people=Person.all
  end

  def show
  end

  def new
    @people=Person.new
  end

  def edit
  end
end
