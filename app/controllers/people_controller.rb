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

  def create
    p "came here"
    person=params[:person]
    @person=Person.new({:first_name=>person[:first_name],:last_name=>person[:last_name]})
    (@person.save && (redirect_to people_path)) || (render 'new')
  end

end
