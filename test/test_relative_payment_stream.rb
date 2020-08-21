# frozen_string_literal: true

require 'test_helper'

# Tests for the RelativePaymentStram class
class TestRelativePaymentStream < Test::Unit::TestCase
  def test_new
    relative_payment = RelativePayment.new(1000, 0.0)
    relative_payment_stream = RelativePaymentStream.new([relative_payment])

    assert_equal(relative_payment, relative_payment_stream[0])
  end

  def test_net_present_value_for_zero_interest_equals_sum_of_amounts
    payment1 = Payment.new(-1000, Date.new(2019, 1, 1))
    payment2 = Payment.new(1600, Date.new(2019, 4, 4))
    payment3 = Payment.new(-2000, Date.new(2019, 7, 7))
    payment4 = Payment.new(1600, Date.new(2019, 10, 10))

    npv = PaymentStream.new([payment1, payment2, payment3, payment4])
                       .to_relative_payment_stream
                       .net_present_value

    assert_in_delta(200.0, npv.call(0), 10**-9)
  end

  def test_net_present_value_returns_expected_manually_computed_result
    payment1 = Payment.new(-1000, Date.new(2019, 1, 1))
    payment2 = Payment.new(500, Date.new(2020, 1, 1))
    payment3 = Payment.new(500, Date.new(2021, 1, 1))

    npv = PaymentStream.new([payment1, payment2, payment3])
                       .to_relative_payment_stream
                       .net_present_value

    assert_in_delta(-625.0, npv.call(1.0), 10**-9)
  end

  def test_net_present_value_derivative_returns_expected_manually_computed_result
    payment1 = Payment.new(-1000, Date.new(2019, 1, 1))
    payment2 = Payment.new(500, Date.new(2020, 1, 1))
    payment3 = Payment.new(500, Date.new(2021, 1, 1))

    npvp = PaymentStream.new([payment1, payment2, payment3])
                        .to_relative_payment_stream
                        .net_present_value_derivative

    assert_in_delta(-250.0, npvp.call(1.0), 10**-9)
  end
end
