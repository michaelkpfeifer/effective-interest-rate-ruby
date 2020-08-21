# frozen_string_literal: true

require 'test_helper'

# Tests for the PaymentStream class
class TestPaymentStream < Test::Unit::TestCase
  def test_new
    payment = Payment.new(1000, Date.new(2020, 1, 1))
    payment_stream = PaymentStream.new([payment])

    assert_equal(payment, payment_stream[0])
  end

  def test_earliest_payment_of_single_payment
    payment = Payment.new(1000, Date.new(2020, 1, 1))
    payment_stream = PaymentStream.new([payment])

    assert_equal(payment, payment_stream.earliest_payment)
  end

  def test_earliest_payment_of_multiple_payments
    earliest_payment = Payment.new(-1000, Date.new(2020, 1, 1))
    payment = Payment.new(500, Date.new(2020, 7, 1))
    newest_payment = Payment.new(500, Date.new(2021, 1, 1))
    payment_stream = PaymentStream.new([newest_payment, payment, earliest_payment])

    assert_equal(earliest_payment, payment_stream.earliest_payment)
  end

  def test_relative_payment_stream_with_one_payment
    payment = Payment.new(1000, Date.new(2020, 1, 1))
    payment_stream = PaymentStream.new([payment])

    relative_payment_stream = payment_stream.to_relative_payment_stream

    assert_equal(1000, relative_payment_stream[0].amount)
    assert_equal(0.0, relative_payment_stream[0].offset)
  end

  def test_offset_for_earliest_payment_in_stream_is_zero
    earliest_payment = Payment.new(-1000, Date.new(2020, 4, 2))
    payment = Payment.new(500, Date.new(2021, 2, 28))
    newest_payment = Payment.new(500, Date.new(2022, 9, 9))
    payment_stream = PaymentStream.new([earliest_payment, payment, newest_payment])

    assert_equal(
      0.0,
      payment_stream
        .to_relative_payment_stream
        .relative_payments
        .find { |p| p.amount == -1000 }
        .offset
    )
  end
end
