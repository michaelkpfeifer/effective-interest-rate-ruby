require 'test/unit'
require 'effective_interest_rate'

class PaymentPointListTest < Test::Unit::TestCase
  def test_new
    payment1 = Payment.new(1000, Date.new(2011, 6, 1))
    payment2 = Payment.new(1000, Date.new(2012, 6, 1))
    payment3 = Payment.new(1000, Date.new(2013, 6, 1))

    payment_list = PaymentList.new

    payment_list << payment1
    payment_list << payment2
    payment_point_list = PaymentPointList.new(payment_list)
    assert_equal payment_point_list.size, 2

    payment_list << payment3
    payment_point_list = PaymentPointList.new(payment_list)
    assert_equal payment_point_list.size, 3
  end

  def test_conversion_to_payment_with_offset_list
    payment1 = Payment.new(1000, Date.new(2013, 6, 1))
    payment2 = Payment.new(1000, Date.new(2014, 6, 1))
    payment3 = Payment.new(1000, Date.new(2015, 6, 1))

    payment_list1 = PaymentList.new

    payment_list1 << payment1
    payment_list1 << payment2
    payment_list1 << payment3

    payment_point_list1 = PaymentPointList.new(payment_list1).sort

    assert_in_delta(0.0, payment_point_list1[0].offset, 10**(-6))
    assert_in_delta(1.0, payment_point_list1[1].offset, 10**(-6))
    assert_in_delta(2.0, payment_point_list1[2].offset, 10**(-6))


    payment4 = Payment.new(1000, Date.new(2013, 1, 1))
    payment5 = Payment.new(1000, Date.new(2014, 2, 1))
    payment6 = Payment.new(1000, Date.new(2015, 3, 1))

    payment_list2 = PaymentList.new

    payment_list2 << payment4
    payment_list2 << payment5
    payment_list2 << payment6

    payment_point_list2 = PaymentPointList.new(payment_list2).sort

    assert_in_delta(0.0, payment_point_list2[0].offset, 10**(-6))
    assert_in_delta((31.0 / 365) + 1, payment_point_list2[1].offset, 10**(-6))
    assert_in_delta(((31.0 + 28.0) / 365) + 2, payment_point_list2[2].offset, 10**(-6))
  end
end
