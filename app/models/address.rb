class Address < ActiveRecord::Base
  validates_presence_of :city,:zip ,:street
  validates_numericality_of :zip

  validates_presence_of :state, :if => Proc.new { |addr| addr.country == "India"} # only validate if the country is India
  validates_length_of :state,:is=>2, :allow_blank => true

  belongs_to :person,:class_name => Person # always on the side where the foreign key is there

  before_save :default_county_if_blank
  
  private
  def default_county_if_blank
    if self.country.blank?
      self.country='India'
    end
  end
end