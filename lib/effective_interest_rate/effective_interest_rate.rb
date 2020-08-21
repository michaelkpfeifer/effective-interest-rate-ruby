# frozen_string_literal: true

# The EffectiveInterestRate class implements the computation of the
# effective interest rate of a stream of payments in a very general
# case.
#
# Details about payment streams can be found in the README.
class EffectiveInterestRate
  START_VALUE = -0.75
  MAX_ITERATION_DIFFERENCE = 10**-9
  MAX_ITERATIONS = 64

  # Computes the effective interest rate of the given payment stream
  # @param payment_stream (PaymentStream) the payment stream whose
  #   effective interest rate is to be computed
  # @return [Float, nil] an approximation of the effective interest
  #   rate of the given payment stream or +nil+ if the effective interest
  #   rate cannot be computed
  def self.compute(payment_stream)
    relative_payment_stream = payment_stream.to_relative_payment_stream

    NewtonIteration.iterate(
      relative_payment_stream.net_present_value,
      relative_payment_stream.net_present_value_derivative,
      START_VALUE,
      MAX_ITERATION_DIFFERENCE,
      MAX_ITERATIONS
    )
  end
end
