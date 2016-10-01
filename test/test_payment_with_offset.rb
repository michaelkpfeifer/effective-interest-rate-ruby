require 'test/unit'
require 'effective_interest_rate'

class PaymentWithOffsetTest < Test::Unit::TestCase
  def test_order
    payment_with_offset1 = PaymentWithOffset.new(1000, 0.0)
    payment_with_offset2 = PaymentWithOffset.new(1000, 1.5)

    assert_operator payment_with_offset1, :<, payment_with_offset2
    assert_operator payment_with_offset2, :>, payment_with_offset1
    assert_operator payment_with_offset1, :<=, payment_with_offset2
    assert_operator payment_with_offset2, :>=, payment_with_offset1
    assert_operator payment_with_offset1, :<=, payment_with_offset1
    assert_operator payment_with_offset2, :>=, payment_with_offset2
  end
end
