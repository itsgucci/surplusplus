class Product < ActiveRecord::Base
  
  validates_numericality_of :quantity, :on => :create, :greater_than => 0, :less_than => 1000
  validates_presence_of :location, :name
  
  named_scope :available, :conditions => "quantity > 0"
  
end
