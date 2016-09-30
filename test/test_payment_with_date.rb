require 'test/unit'
require 'effective_interest_rate'

class PaymentTest < Test::Unit::TestCase
  def test_order
    payment1 = Payment.new(1000, Date.new(2011, 1, 1))
    payment2 = Payment.new(1000, Date.new(2012, 1, 1))

    assert_operator payment1, :<, payment2
    assert_operator payment2, :>, payment1
    assert_operator payment1, :<=, payment2
    assert_operator payment2, :>=, payment1
    assert_operator payment1, :<=, payment1
    assert_operator payment2, :>=, payment2
  end

  def test_sort
    payment1 = Payment.new(1000, Date.new(2011, 1, 1))
    payment2 = Payment.new(1000, Date.new(2012, 1, 1))
    payment3 = Payment.new(1000, Date.new(2013, 1, 1))

    assert_equal [payment1, payment2, payment3].sort.reverse.first, payment3
    assert_equal [payment1, payment2, payment3].min, payment1
    assert_equal [payment1, payment2, payment3].max, payment3
  end
end
