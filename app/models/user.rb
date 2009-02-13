class User < ActiveRecord::Base
  
  # perhaps in the future this will have an opt-in flag or something, for now, everybody wants it
  named_scope :wants_daily_email
  
end
