class EffectiveInterestRateCalculator
  MAX_NUM_ITERATIONS = 64
  MAX_DIFF_ITERATIONS = 10**-10

  # Essentially, @payments_with_offset is a list
  #   [(A_1, t_1), ..., (A_n, t_n)]
  # of payments A_k with offsets t_k (in years). @payments_with_offset
  # defines a function
  #   S(X) = \sum_{k = 1}^n A_n * (1 + X)^{-t_k}.
  # The derivative of S is
  #   S'(X) = \sum_{k = 1}^n A_n * (-t_k) * (1 + X)^{-t_k - 1}.
  # The derivative has the same structure as the original function, so
  # we can store it in the same way. We simply represent the
  # derivative as
  #   [(-t_1 * A_1, -t_1 - 1), ..., (-t_k * A_k, -t_k - 1)].

  attr_reader :payments_with_date
  attr_reader :payments_with_offset
  attr_reader :payments_with_offset_derivative

  def initialize
    self.payments_with_date = []
  end

  def <<(payment_with_date)
    payments_with_date << payment_with_date
  end

  def effective_interest_rate
    convert_to_payments_with_offset
    derive
    effective_interest_rate_loop
  end

  private

  def convert_to_payments_with_offset
    first_payment_date = payments_with_date.min.date
    first_payment_offset = offset_in_year(first_payment_date)
    first_payment_year = first_payment_date.year

    self.payments_with_offset = []
    payments_with_date.each do |payment_with_date|
      offset = payment_offset(payment_with_date,
                              first_payment_year,
                              first_payment_offset)
      payment_with_offset = PaymentWithOffset.new(payment_with_date.amount, offset)
      payments_with_offset << payment_with_offset
    end
  end

  def payment_offset(payment_with_date, first_payment_year, first_payment_offset)
    year_difference = payment_with_date.date.year - first_payment_year
    offset = offset_in_year(payment_with_date.date)
    offset = offset + year_difference - first_payment_offset
    offset
  end

  def offset_in_year(date)
    if date.leap?
      payment_offset = (date.yday - 1) / 366.0
    else
      payment_offset = (date.yday - 1) / 365.0
    end
    payment_offset
  end

  def derive
    self.payments_with_offset_derivative = []
    payments_with_offset.each do |payment_with_offset|
      amount = payment_with_offset.amount
      offset = payment_with_offset.offset
      payments_with_offset_derivative << PaymentWithOffset.new(-1 * offset * amount, - (- offset - 1))
    end
  end

  def effective_interest_rate_loop
    previous_iteration = -0.75
    next_iteration = previous_iteration
    MAX_NUM_ITERATIONS.times do
      nominator = evaluate(payments_with_offset, previous_iteration)
      denominator = evaluate(payments_with_offset_derivative, previous_iteration)
      next_iteration = previous_iteration - (nominator / denominator)
      if (next_iteration - previous_iteration).abs < MAX_DIFF_ITERATIONS
        break
      end

      previous_iteration = next_iteration
    end
    next_iteration
  end

  def evaluate(terms, x)
    value = 0.0
    terms.each do |payment_with_offset|
      amount = payment_with_offset.amount
      offset = payment_with_offset.offset
      value = value + amount * (1 + x)**-offset
    end
    value
  end

  attr_writer :payments_with_date
  attr_writer :payments_with_offset
  attr_writer :payments_with_offset_derivative
end
