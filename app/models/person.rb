class Person < ActiveRecord::Base
  validates_presence_of :first_name,:last_name  # should not be of zero length or nil
  has_many :addresses

  def full_name
    space=" "
    first_name<<space<<get_middle_name<<last_name
  end

  private

  def get_middle_name
    name=middle_name||""
    (name.blank?) ? name : (name<<" ")
  end

  #find records based on partial match on first or last name.
  #typing "Jon" -> Peter jones,Jona Smith

  def self.find_by_names_starting_with text
    Person.where("first_name LIKE :term OR last_name LIKE :term",:term=>text+"%").order('first_name ASC')
  end

end
