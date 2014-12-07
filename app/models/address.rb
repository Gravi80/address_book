class Address < ActiveRecord::Base
  validates_presence_of :city,:zip ,:street
  validates_numericality_of :zip
  belongs_to :person # always on the side where the foreign key is there

  before_save :default_county_if_blank
  
  private
  def default_county_if_blank
    if self.country.blank?
      self.country='India'
    end
  end
end