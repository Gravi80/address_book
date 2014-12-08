class Person < ActiveRecord::Base
  validates_presence_of :first_name,:last_name  # should not be of zero length or nil
  has_many :addresses
  has_many :messages,:class_name => Message,:foreign_key => :recipient_id
  has_many :unread_messages,-> { where read_at: nil }, :class_name => Message , :foreign_key => :recipient_id
  accepts_nested_attributes_for :addresses  # works only when you have a association

  # benefits => are composable,  find_by_names_starting_with('text').count  will fire another SQl query for count
  #you can also do find_by_names_starting_with('text').addresses
  scope :find_by_names_starting_with, ->(term) {
    where("first_name LIKE :term OR last_name LIKE :term",:term=>term+"%").
    order('first_name ASC')
  }

  def full_name
    space=" "
    first_name<<space<<get_middle_name<<last_name
  end

  def add_address address
      self.addresses<<address
  end

  private

  def get_middle_name
    name=middle_name||""
    (name.blank?) ? name : (name<<" ")
  end

  #find records based on partial match on first or last name.
  #typing "Jon" -> Peter jones,Jona Smith

  # will return an array and    find_by_names_starting_with('text').count  will return size of array i.e does a ruby operation on it
  # def self.find_by_names_starting_with text
  #   Person.where("first_name LIKE :term OR last_name LIKE :term",:term=>text+"%").order('first_name ASC')
  # end

end
