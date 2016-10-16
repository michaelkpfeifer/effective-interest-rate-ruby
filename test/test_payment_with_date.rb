require 'test/unit'
require 'effective_interest_rate'

class PaymentWithDateTest < Test::Unit::TestCase
  def setup
    @payment_with_date1 = PaymentWithDate.new(1000, Date.new(2011, 1, 1))
    @payment_with_date2 = PaymentWithDate.new(1000, Date.new(2012, 1, 1))
    @payment_with_date3 = PaymentWithDate.new(1000, Date.new(2013, 1, 1))
  end

  def test_order
    assert_operator @payment_with_date1, :<, @payment_with_date2
    assert_operator @payment_with_date2, :>, @payment_with_date1
    assert_operator @payment_with_date1, :<=, @payment_with_date2
    assert_operator @payment_with_date2, :>=, @payment_with_date1
    assert_operator @payment_with_date1, :<=, @payment_with_date1
    assert_operator @payment_with_date2, :>=, @payment_with_date2
  end

  def test_sort
    assert_equal([@payment_with_date1, @payment_with_date2, @payment_with_date3].sort.reverse.first,
                 @payment_with_date3)
    assert_equal([@payment_with_date1, @payment_with_date2, @payment_with_date3].min,
                 @payment_with_date1)
    assert_equal([@payment_with_date1, @payment_with_date2, @payment_with_date3].max,
                 @payment_with_date3)
  end
end
