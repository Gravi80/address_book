class Item < ActiveRecord::Base

  validates_presence_of :name, :price

  has_many :order_items, :dependent => :destroy # if item gets deleted then its joined record also gets deleted

  scope :by_popularity,-> { includes(:order_items).group('items.id,order_items.id,order_items.item_id').order('COUNT(order_items.item_id) DESC').references(:order_items) }

end