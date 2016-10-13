require 'test/unit'
require 'effective_interest_rate'

class PaymentWithOffsetListTest < Test::Unit::TestCase
  def setup
    @payment_with_date1 = PaymentWithDate.new(2000, Date.new(2013, 6, 1))
    @payment_with_date2 = PaymentWithDate.new(-1000, Date.new(2014, 6, 1))
    @payment_with_date3 = PaymentWithDate.new(-1000, Date.new(2015, 6, 1))
    @payment_with_date4 = PaymentWithDate.new(-100, Date.new(2015, 7, 1))
  end

  def test_initialization
    payment_with_date_list = PaymentWithDateList.new

    payment_with_date_list << @payment_with_date1
    payment_with_date_list << @payment_with_date2
    payment_with_offset_list = PaymentWithOffsetList.new(payment_with_date_list)
    assert_equal payment_with_offset_list.size, 2

    payment_with_date_list << @payment_with_date3
    payment_with_offset_list = PaymentWithOffsetList.new(payment_with_date_list)
    assert_equal payment_with_offset_list.size, 3
  end

  def test_conversion_to_payment_with_offset_list
    payment_with_date_list1 = PaymentWithDateList.new

    payment_with_date_list1 << @payment_with_date1
    payment_with_date_list1 << @payment_with_date2
    payment_with_date_list1 << @payment_with_date3

    payment_with_offset_list1 = PaymentWithOffsetList.new(payment_with_date_list1).payment_with_offset_list.sort

    assert_in_delta(0.0, payment_with_offset_list1[0].offset, 10**(-6))
    assert_in_delta(1.0, payment_with_offset_list1[1].offset, 10**(-6))
    assert_in_delta(2.0, payment_with_offset_list1[2].offset, 10**(-6))

    payment_with_date11 = PaymentWithDate.new(2000, Date.new(2013, 1, 1))
    payment_with_date12 = PaymentWithDate.new(-1000, Date.new(2014, 2, 1))
    payment_with_date13 = PaymentWithDate.new(-1000, Date.new(2015, 3, 1))

    payment_with_date_list2 = PaymentWithDateList.new

    payment_with_date_list2 << payment_with_date11
    payment_with_date_list2 << payment_with_date12
    payment_with_date_list2 << payment_with_date13

    payment_with_offset_list2 = PaymentWithOffsetList.new(payment_with_date_list2).payment_with_offset_list.sort

    assert_in_delta(0.0, payment_with_offset_list2[0].offset, 10**(-6))
    assert_in_delta((31.0 / 365) + 1, payment_with_offset_list2[1].offset, 10**(-6))
    assert_in_delta(((31.0 + 28.0) / 365) + 2, payment_with_offset_list2[2].offset, 10**(-6))
  end

  def test_effective_interest_rate
    payment_with_date_list1 = PaymentWithDateList.new
    payment_with_date_list1 << @payment_with_date1
    payment_with_date_list1 << @payment_with_date2
    payment_with_date_list1 << @payment_with_date3
    payment_with_offset_list1 = PaymentWithOffsetList.new(payment_with_date_list1)
    assert_in_delta(0.0, payment_with_offset_list1.effective_interest_rate, 10**-6)

    payment_with_date_list2 = payment_with_date_list1.dup
    payment_with_date_list2 << @payment_with_date4
    payment_with_offset_list2 = PaymentWithOffsetList.new(payment_with_date_list2)
    assert_operator payment_with_offset_list2.effective_interest_rate, :>, 0.0

    payment_with_date_list3 = PaymentWithDateList.new
    payment_with_date_list3 << PaymentWithDate.new(240000, Date.new(2015, 1, 1))
    (0..19).each do |year|
      (1..12).each do |month|
        payment_with_date_list3 << PaymentWithDate.new(-1200, Date.new(2015 + year, month, 1))
      end
    end
    payment_with_offset_list3 = PaymentWithOffsetList.new(payment_with_date_list3)
    assert_in_delta(1.91 / 100, payment_with_offset_list3.effective_interest_rate, 0.001)
  end
end
