# frozen_string_literal: true

# Instances of the {Payment} class represent payments.
class Payment
  # The amount of the current payment
  # @return  [Numeric] the amount of the current payment
  attr_reader :amount

  # The date of the current payment
  # @return [Date] the date of the current paymenta
  attr_reader :date

  # Takes an amount and a date and returns an instance of the
  # {Payment} class representing the corresponding payment
  # @param amount [Numeric] the amount of the payment
  # @param date [Date] the date of the payment
  def initialize(amount, date)
    self.amount = amount
    self.date = date
  end

  # Takes a reference payment and returns a relative payment (relative
  # to the given reference payment) corresponding to the current
  # payment
  # @param reference_payment [Payment] the reference payment
  # @return [RelativePayment] a relative payment (relative to the
  #   given reference payment) corresponding to the current payment
  def to_relative_payment(reference_payment)
    RelativePayment.new(
      amount,
      (date.year - reference_payment.date.year) +
      (offset_in_year - reference_payment.offset_in_year)
    )
  end

  protected

  def offset_in_year
    if date.leap?
      (date.yday - 1) / 366.0
    else
      (date.yday - 1) / 365.0
    end
  end

  private

  attr_writer :amount
  attr_writer :date
end
