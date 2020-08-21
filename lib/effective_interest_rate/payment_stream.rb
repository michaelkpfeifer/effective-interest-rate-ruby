# frozen_string_literal: true

require 'date'

# Instances of the {PaymentStream} class represent payment streams
class PaymentStream
  # An array of {Payment} objects representing the current payment
  # stream
  # @return {Array<Payment>} an array of {Payment} objects
  #   representing the current payment stream
  attr_reader :payments

  # Takes an array of payments and returns an instance of the
  # {PaymentStream} class representing the current payment stream
  # @param payments [Array<Payment>] an array of payments representing
  #   the current payment stream
  def initialize(payments)
    self.payments = payments
  end

  # Takes an integer index and returns the index-th payment in the
  # current payment stream
  # @param index [Integer] the index of the payment in the current payment stream
  # @return [Payment] the index-th payment of the current payment stream
  def [](index)
    payments[index]
  end

  # Finds the earliest payment in the current payment stream
  # @return [Payment] the earliest payment in the current payment stream
  def earliest_payment
    payments.min_by(&:date)
  end

  # Converts the current payment stream to a corresponding relative
  # payment stream with respect to the earliest payment in the current
  # stream
  # @return [RelativePaymentStream] the corresponding relative payment
  #   stream with respect to the earliest payment in the current stream
  def to_relative_payment_stream
    reference_payment = earliest_payment
    RelativePaymentStream.new(payments.map { |payment| payment.to_relative_payment(reference_payment) })
  end

  private

  attr_writer :payments
end
