require 'test/unit'
require 'effective_interest_rate'

class PaymentWithDateListTest < Test::Unit::TestCase
  def setup
    @payment_with_date01 = PaymentWithDate.new(1000, Date.new(2011, 1, 1))
    @payment_with_date02 = PaymentWithDate.new(1000, Date.new(2012, 1, 1))
    @payment_with_date03 = PaymentWithDate.new(1000, Date.new(2013, 1, 1))
  end

  def test_add
    payment_with_date_list = PaymentWithDateList.new
    assert_equal payment_with_date_list.size, 0

    payment_with_date_list << @payment_with_date01
    assert_equal payment_with_date_list.size, 1
    payment_with_date_list << @payment_with_date02
    assert_equal payment_with_date_list.size, 2
    payment_with_date_list << @payment_with_date03
    assert_equal payment_with_date_list.size, 3
  end

  def test_order
    payment_with_date_list = PaymentWithDateList.new
    payment_with_date_list << @payment_with_date02
    payment_with_date_list << @payment_with_date03
    payment_with_date_list << @payment_with_date01
    assert_equal payment_with_date_list.min_date, Date.new(2011, 1, 1)
    assert_equal payment_with_date_list.max_date, Date.new(2013, 1, 1)
  end

  def test_effective_interest_rate_for_monthly_payment
    payment_with_date_list = PaymentWithDateList.new
    payment_with_date_list << PaymentWithDate.new(240_000, Date.new(2015, 1, 1))
    (0..19).each do |year|
      (1..12).each do |month|
        payment_with_date_list << PaymentWithDate.new(-1200, Date.new(2015 + year, month, 1))
      end
    end
    assert_in_delta(1.91 / 100, payment_with_date_list.effective_interest_rate, 0.001)
  end
end
