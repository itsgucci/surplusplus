class PostOffice < ActionMailer::Base

  def daily_inventory(recipient)
    
    products = Product.available
    
    subject    "Inventory as of #{Time.now.strftime('%D')}"
    recipients recipient.email
    from       'inventory@surplus.localgarden.us'
    sent_on    Time.now
    body       :recipient => recipient, :products => products
  end

end
