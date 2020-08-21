# frozen_string_literal: true

require 'test_helper'

# Tests for the RelativePayment class
class TestRelativePayment < Test::Unit::TestCase
  def test_new
    relative_payment = RelativePayment.new(1000, 1.0)

    assert_equal(1000, relative_payment.amount)
    assert_equal(1.0, relative_payment.offset)
  end
end
