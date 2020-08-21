# frozen_string_literal: true

require 'test_helper'

# Tests for the EffectiveInterestRate class
class TestEffectiveInterestRate < Test::Unit::TestCase
  def test_effective_interest_rate_is_0_in_very_simple_case
    payment_stream = PaymentStream.new(
      [Payment.new(2000, Date.new(2013, 6, 1)),
       Payment.new(-1000, Date.new(2014, 6, 1)),
       Payment.new(-1000, Date.new(2015, 6, 1))]
    )

    effective_interest_rate = EffectiveInterestRate.compute(payment_stream)

    assert_in_delta(0.0, effective_interest_rate, 10**-6)
  end

  def test_effective_interest_rate_has_the_expected_sign_in_a_simple_case
    payment_stream = PaymentStream.new(
      [Payment.new(2000, Date.new(2013, 6, 1)),
       Payment.new(-1000, Date.new(2014, 6, 1)),
       Payment.new(-1000, Date.new(2015, 6, 1)),
       Payment.new(-100, Date.new(2015, 7, 1))]
    )

    effective_interest_rate = EffectiveInterestRate.compute(payment_stream)

    assert_operator effective_interest_rate, :>, 0.0
  end

  def test_compute_returns_the_expected_value_for_a_stream_of_monthly_payments
    payments = [Payment.new(240_000, Date.new(2015, 1, 1))]
    (2015..2034).each do |year|
      (1..12).each do |month|
        payments << Payment.new(-1200, Date.new(year, month, 1))
      end
    end

    effective_interest_rate = EffectiveInterestRate.compute(PaymentStream.new(payments))

    assert_in_delta(1.91 / 100, effective_interest_rate, 10**-3)
  end

  def test_compute_returns_the_expected_value_for_a_simple_real_life_case
    payment_stream = PaymentStream.new(
      [Payment.new(-1065.25, Date.new(2011, 4, 21)),
       Payment.new(130.69, Date.new(2014, 5, 23))]
    )

    effective_interest_rate = EffectiveInterestRate.compute(payment_stream)

    assert_in_delta(-0.4931, effective_interest_rate, 10**-3)
  end
end
