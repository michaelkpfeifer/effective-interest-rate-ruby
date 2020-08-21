# frozen_string_literal: true

require 'test_helper'

# Tests for the NewtonIteration class
class TestNewtonIteration < Test::Unit::TestCase
  def test_iterate_finds_root_of_identity_function
    f = ->(x) { x }
    fp = ->(_x) { 1 }

    root = NewtonIteration.iterate(f, fp, 1.0, 10**-9, 4)

    assert_in_delta(0.0, root, 10**-9)
  end

  def test_iterate_does_not_find_root_of_forth_power_in_4_iterations
    f = ->(x) { x**4 - 1 }
    fp = ->(x) { 4 * x**3 }

    root = NewtonIteration.iterate(f, fp, 2.0, 10**-9, 4)

    assert_equal nil, root
  end

  def test_iterate_finds_root_of_forth_power_in_less_than_8_iterations
    f = ->(x) { x**4 - 1 }
    fp = ->(x) { 4 * x**3 }

    root = NewtonIteration.iterate(f, fp, 2.0, 10**-9, 8)

    assert_in_delta(1.0, root, 10**-9)
  end
end
