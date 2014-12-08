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

  # In order to build a deeply nested relationship like this, you will have to loop through your
  # "built" association , and invoke build again on its has_many association.
  def create
     @person=Person.new(person_params)
    (@person.save && (redirect_to people_path)) || (render 'new')
  end

  #to avoid ActiveModel::ForbiddenAttributesError error
  private
  def person_params
    params.require(:person).permit(:first_name, :last_name,addresses_attributes:[:city,:street,:zip,:state])
  end

end
