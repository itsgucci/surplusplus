require 'test_helper'

class PostOfficeTest < ActionMailer::TestCase
  tests PostOffice
  def test_daily_inventory
    @expected.subject = 'PostOffice#daily_inventory'
    @expected.body    = read_fixture('daily_inventory')
    @expected.date    = Time.now

    assert_equal @expected.encoded, PostOffice.create_daily_inventory(@expected.date).encoded
  end

end
