require 'test/unit'
require 'effective_interest_rate'

class PaymentWithDateListTest < Test::Unit::TestCase
  def test_add
    payment_with_date_list = PaymentWithDateList.new
    assert_equal payment_with_date_list.size, 0

    payment_with_date1 = PaymentWithDate.new(1000, Date.new(2011, 1, 1))
    payment_with_date2 = PaymentWithDate.new(1000, Date.new(2012, 1, 1))
    payment_with_date3 = PaymentWithDate.new(1000, Date.new(2013, 1, 1))

    payment_with_date_list << payment_with_date1
    assert_equal payment_with_date_list.size, 1
    payment_with_date_list << payment_with_date2
    assert_equal payment_with_date_list.size, 2
    payment_with_date_list << payment_with_date3
    assert_equal payment_with_date_list.size, 3
  end

  def test_order
    payment_with_date_list = PaymentWithDateList.new
    payment_with_date1 = PaymentWithDate.new(1000, Date.new(2011, 1, 1))
    payment_with_date2 = PaymentWithDate.new(1000, Date.new(2012, 1, 1))
    payment_with_date3 = PaymentWithDate.new(1000, Date.new(2013, 1, 1))
    payment_with_date_list << payment_with_date2
    payment_with_date_list << payment_with_date3
    payment_with_date_list << payment_with_date1
    assert_equal payment_with_date_list.min.date, Date.new(2011, 1, 1)
    assert_equal payment_with_date_list.max.date, Date.new(2013, 1, 1)
  end
end
