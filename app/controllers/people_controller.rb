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

  def create
    person=params[:person]
    @person=Person.new({:first_name=>person[:first_name],:last_name=>person[:last_name]})
    (@person.save && (redirect_to people_path)) || (render 'new')
  end

end
