require 'test/unit'
require 'effective_interest_rate'

class PaymentPointTest < Test::Unit::TestCase
  def test_order
    payment_point1 = PaymentPoint.new(1000, 0.0)
    payment_point2 = PaymentPoint.new(1000, 1.5)

    assert_operator payment_point1, :<, payment_point2
    assert_operator payment_point2, :>, payment_point1
    assert_operator payment_point1, :<=, payment_point2
    assert_operator payment_point2, :>=, payment_point1
    assert_operator payment_point1, :<=, payment_point1
    assert_operator payment_point2, :>=, payment_point2
  end
end
