require 'test/unit'
require 'effective_interest_rate'

class PaymentTest < Test::Unit::TestCase
  def test_order
    p1 = Payment.new(1000, Date.new(2011, 1, 1))
    p2 = Payment.new(1000, Date.new(2012, 1, 1))

    assert_operator p1, :<, p2
    assert_operator p2, :>, p1
    assert_operator p1, :<=, p2
    assert_operator p2, :>=, p1
    assert_operator p1, :<=, p1
    assert_operator p2, :>=, p2
  end

  def test_sort
    p1 = Payment.new(1000, Date.new(2011, 1, 1))
    p2 = Payment.new(1000, Date.new(2012, 1, 1))
    p3 = Payment.new(1000, Date.new(2013, 1, 1))

    assert_equal [p1, p2, p3].sort.reverse.first, p3
    assert_equal [p1, p2, p3].min, p1
    assert_equal [p1, p2, p3].max, p3
  end
end
