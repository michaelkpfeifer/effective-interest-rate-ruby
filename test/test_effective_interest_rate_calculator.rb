require 'test_helper'

class EffectiveInterestRateCalculatorTest < Test::Unit::TestCase
  def setup
    @payment_with_date1 = PaymentWithDate.new(2000, Date.new(2013, 6, 1))
    @payment_with_date2 = PaymentWithDate.new(-1000, Date.new(2014, 6, 1))
    @payment_with_date3 = PaymentWithDate.new(-1000, Date.new(2015, 6, 1))
    @payment_with_date4 = PaymentWithDate.new(-100, Date.new(2015, 7, 1))
  end

  def test_effective_interest_rate_for_very_simple_case
    eirc = EffectiveInterestRateCalculator.new
    eirc << @payment_with_date1
    eirc << @payment_with_date2
    eirc << @payment_with_date3
    assert_in_delta(0.0, eirc.effective_interest_rate, 10**-6)
  end

  def test_effective_interest_rate_for_simple_case
    eirc = EffectiveInterestRateCalculator.new
    eirc << @payment_with_date1
    eirc << @payment_with_date2
    eirc << @payment_with_date3
    eirc << @payment_with_date4
    assert_operator eirc.effective_interest_rate, :>, 0.0
  end

  def test_effective_interest_rate_for_monthly_payment
    eirc = EffectiveInterestRateCalculator.new
    eirc << PaymentWithDate.new(240_000, Date.new(2015, 1, 1))
    (0..19).each do |year|
      (1..12).each do |month|
        eirc << PaymentWithDate.new(-1200, Date.new(2015 + year, month, 1))
      end
    end
    assert_in_delta(1.91 / 100, eirc.effective_interest_rate, 10**-4)
  end
end
