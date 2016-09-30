require 'test/unit'
require 'effective_interest_rate'

class PaymentListTest < Test::Unit::TestCase
  def test_add
    payment_list = PaymentList.new
    assert_equal payment_list.size, 0

    payment1 = Payment.new(1000, Date.new(2011, 1, 1))
    payment2 = Payment.new(1000, Date.new(2012, 1, 1))
    payment3 = Payment.new(1000, Date.new(2013, 1, 1))

    payment_list << payment1
    assert_equal payment_list.size, 1
    payment_list << payment2
    assert_equal payment_list.size, 2
    payment_list << payment3
    assert_equal payment_list.size, 3
  end

  def test_order
    payment_list = PaymentList.new
    payment1 = Payment.new(1000, Date.new(2011, 1, 1))
    payment2 = Payment.new(1000, Date.new(2012, 1, 1))
    payment3 = Payment.new(1000, Date.new(2013, 1, 1))
    payment_list << payment2
    payment_list << payment3
    payment_list << payment1
    assert_equal payment_list.min.date, Date.new(2011, 1, 1)
    assert_equal payment_list.max.date, Date.new(2013, 1, 1)
  end
end
