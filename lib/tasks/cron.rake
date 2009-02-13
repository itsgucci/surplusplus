namespace :cron do

  desc "Sends inventory to all users"
  task( :send_email => :environment ) do
    User.wants_daily_email.each do |user|
      PostOffice.deliver_daily_inventory(user)
      puts "Email sent to #{user.name}"
    end
  end

end