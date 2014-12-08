class Customer < Person
  has_many :orders,:dependent => :destroy do
    def most_recent
      order('created_at DESC').first
    end
  end

end