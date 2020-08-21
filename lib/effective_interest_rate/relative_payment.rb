# frozen_string_literal: true

# Instances of the {RelativePayment} class represent relative
# payments.
class RelativePayment
  # The amount of the current payment
  # @return [Numeric] the amount of the current payment
  attr_reader :amount

  # The time difference between two payments expressed in years
  # @return [Float] the time difference between two payments
  #   expressed in years
  attr_reader :offset

  # Takes an amount and a time difference between two payments
  # expressed in years and returns an instance of the {RelativePayment}
  # class representing the corresponding relative payment
  # @param amount [Numeric] the amount of the relative payment
  # @param offset [Float] the time difference between two payments
  #   expressed in years
  def initialize(amount, offset)
    self.amount = amount
    self.offset = offset
  end

  private

  attr_writer :amount
  attr_writer :offset
end
