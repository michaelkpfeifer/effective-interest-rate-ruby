class EffectiveInterestRateCalculator
  MAX_NUM_ITERATIONS = 16
  MAX_DIFF_ITERATIONS = 10**-10

  def initialize
    @payments_with_date = []
  end

  def <<(payment_with_date)
    @payments_with_date << payment_with_date
  end

  def effective_interest_rate
    @payments_with_offset = convert_to_payments_with_offset
    @payments_with_offset_derivative = derive(@payments_with_offset)
    effective_interest_rate_loop
  end

  private

  def convert_to_payments_with_offset
    first_payment_date = @payments_with_date.min.date
    first_payment_offset = payment_offset_in_year(first_payment_date)
    first_payment_year = first_payment_date.year

    payments_with_offset = []
    @payments_with_date.each do |payment_with_date|
      offset = payment_offset(payment_with_date,
                              first_payment_year,
                              first_payment_offset)
      payment_with_offset = PaymentWithOffset.new(payment_with_date.amount, offset)
      payments_with_offset << payment_with_offset
    end
    payments_with_offset
  end

  def payment_offset(payment_with_date, first_payment_year, first_payment_offset)
    year_difference = payment_with_date.date.year - first_payment_year
    offset = payment_offset_in_year(payment_with_date.date)
    offset = offset + year_difference - first_payment_offset
    offset
  end

  def payment_offset_in_year(date)
    if date.leap?
      payment_offset = (date.yday - 1) / 366.0
    else
      payment_offset = (date.yday - 1) / 365.0
    end
    payment_offset
  end

  def derive(payments)
    derivative = []
    payments.each do |payment_with_offset|
      amount = payment_with_offset.amount
      offset = payment_with_offset.offset
      derivative << PaymentWithOffset.new(-1 * offset * amount, - (- offset - 1))
    end
    derivative
  end

  def effective_interest_rate_loop
    previous_iteration = 0.0
    next_iteration = previous_iteration
    MAX_NUM_ITERATIONS.times do
      nominator = evaluate(@payments_with_offset, previous_iteration)
      denominator = evaluate(@payments_with_offset_derivative, previous_iteration)
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
end
