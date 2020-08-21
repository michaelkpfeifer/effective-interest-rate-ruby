# frozen_string_literal: true

require 'test_helper'

# Tests for the Payment class
class TestPayment < Test::Unit::TestCase
  def test_new
    payment = Payment.new(1000, Date.new(2020, 1, 1))

    assert_equal(1000, payment.amount)
    assert_equal(Date.new(2020, 1, 1), payment.date)
  end

  def test_relative_payment_relative_to_itself_has_zero_time_difference
    payment1 = Payment.new(1000, Date.new(2020, 1, 1))
    payment2 = Payment.new(2000, Date.new(2020, 1, 1))

    relative_payment2 = payment2.to_relative_payment(payment1)

    assert_equal(2000, relative_payment2.amount)
    assert_equal(0.0, relative_payment2.offset)
  end

  def test_computation_of_relative_payment_respects_non_leap_year
    payment_jan01 = Payment.new(-1000, Date.new(2019, 1, 1))
    payment_jan02 = Payment.new(500, Date.new(2019, 1, 2))
    payment_dec31 = Payment.new(500, Date.new(2019, 12, 31))

    relative_payment_jan02 = payment_jan02.to_relative_payment(payment_jan01)
    relative_payment_dec31 = payment_dec31.to_relative_payment(payment_jan01)

    assert_in_delta(1 / 365.0, relative_payment_jan02.offset, 10**-9)
    assert_in_delta(364 / 365.0, relative_payment_dec31.offset, 10**-9)
  end

  def test_computation_of_relative_payment_respects_leap_year
    payment_jan01 = Payment.new(-1000, Date.new(2020, 1, 1))
    payment_jan02 = Payment.new(500, Date.new(2020, 1, 2))
    payment_dec31 = Payment.new(500, Date.new(2020, 12, 31))

    relative_payment_jan02 = payment_jan02.to_relative_payment(payment_jan01)
    relative_payment_dec31 = payment_dec31.to_relative_payment(payment_jan01)

    assert_in_delta(1 / 366.0, relative_payment_jan02.offset, 10**-9)
    assert_in_delta(365 / 366.0, relative_payment_dec31.offset, 10**-9)
  end

  def test_computation_of_relative_payment_respects_leap_year_across_year_boundaries
    payment1 = Payment.new(-1000, Date.new(2019, 12, 1))
    payment2 = Payment.new(1000, Date.new(2020, 1, 31))

    relative_payment2 = payment2.to_relative_payment(payment1)

    assert_in_delta(1 - 334 / 365.0 + 30 / 366.0, relative_payment2.offset, 10**-9)
  end
end
