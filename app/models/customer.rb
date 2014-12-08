class Customer < Person
  has_many :orders,:dependent => :destroy
end