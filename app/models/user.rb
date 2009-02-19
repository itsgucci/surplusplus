class User < ActiveRecord::Base
  
  validates_presence_of :email
  validates_uniqueness_of :email, :message => "has already been signed up"
  
  # perhaps in the future this will have an opt-in flag or something, for now, everybody wants it
  named_scope :wants_daily_email
  
end
