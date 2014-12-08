class Customer < Person
  has_many :orders,:dependent => :destroy do
    def most_recent
      order('created_at DESC').first
    end
  end

  #If you want to add conditions to your included models you’ll have to explicitly reference them. For example:

  # User.includes(:posts).where('posts.name = ?', 'example')
  #Doesn't JOIN the posts table, resulting in an error.

  #but this will work:
  # User.includes(:posts).where('posts.name = ?', 'example').references(:posts)
  #Query now knows the string references posts, so adds a JOIN

  scope :loyal_last_90_days,-> { includes(:orders).where('orders.created_at >= ?', 90.days.ago).references(:orders) }
  scope :min_2_items,->{ includes(:orders=>:order_items).where('order_items.id > 0').group('order_items.id,orders.id,people.id').having('COUNT(order_items.id) >= 2').references(:order_items)}

end