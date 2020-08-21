# frozen_string_literal: true

# Instances of the {RelativePaymentStream} class represent relative
# payment streams
class RelativePaymentStream
  # An array of {RelativePayment} objects representing the current
  # relative payment stream
  # @return {Array<RelativePayment>} an array of {RelativePayment}
  #   objects representing the current relative payment stream
  attr_reader :relative_payments

  # Takes an array of relative payments and returns an instance of the
  # {RelativePaymentStream} class representing the current relative
  # payment stream
  # @param relative_payments [Array<RelativePayment>] an array of
  #   relative payments representing the current relative payment stream
  def initialize(relative_payments)
    self.relative_payments = relative_payments
  end

  # Takes an integer index and returns the index-th relative payment
  # in the current relative payment stream
  # @param index [Integer] the index of the relative payment in the
  #   current relative payment stream
  # @return [RelativePayment] the index-th relative payment in the
  #   current relative payment stream
  def [](index)
    relative_payments[index]
  end

  # Returns the net present value function of the payment stream as an
  # anonymous function
  # @return [Proc] the net present value function
  def net_present_value
    lambda do |x|
      relative_payments.reduce(0) do |sum, relative_payment|
        sum + relative_payment.amount * (1 + x)**-relative_payment.offset
      end
    end
  end

  # Returns the derivative of the net present value function of the
  # payment stream as an anonymous function
  # @return [Proc] the derivative of the net present value function
  def net_present_value_derivative
    lambda do |x|
      relative_payments.reduce(0) do |sum, relative_payment|
        sum + relative_payment.amount * -relative_payment.offset * (1 + x)**(-relative_payment.offset - 1)
      end
    end
  end

  private

  attr_writer :relative_payments
end
