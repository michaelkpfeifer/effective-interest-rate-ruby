class PaymentWithOffsetList
  MAX_NUM_ITERATIONS = 16
  MAX_DIFF_ITERATIONS = 10**-10

  attr_accessor :payments
  attr_accessor :payments_derivative

  def initialize(payment_with_date_list)
    first_payment_date = payment_with_date_list.min_date
    first_payment_offset = payment_offset_in_year(first_payment_date)
    first_payment_year = first_payment_date.year

    @payments = []
    payment_with_date_list.payment_with_date_list.each do |payment_with_date|
      payment_with_date_date = payment_with_date.date
      year_difference = payment_with_date_date.year - first_payment_year
      offset = payment_offset_in_year(payment_with_date_date)
      offset = offset + year_difference - first_payment_offset
      payment_with_offset = PaymentWithOffset.new(payment_with_date.amount, offset)
      @payments << payment_with_offset
    end

    @payments_derivative = payments_derivative(@payments)
  end

  def size
    @payments.size
  end

  def sorted_offsets
    @payments.map(&:offset).sort
  end

  def effective_interest_rate
    previous_iteration = 0.0
    next_iteration = previous_iteration
    MAX_NUM_ITERATIONS.times do
      nominator = evaluate(@payments, previous_iteration)
      denominator = evaluate(@payments_derivative, previous_iteration)
      next_iteration = previous_iteration - (nominator / denominator)
      if (next_iteration - previous_iteration).abs < MAX_DIFF_ITERATIONS
        return next_iteration
      end

      previous_iteration = next_iteration
    end

    next_iteration
  end

  private

  def evaluate(terms, x)
    value = 0.0
    terms.each do |payment_with_offset|
      amount = payment_with_offset.amount
      offset = payment_with_offset.offset
      value = value + amount * (1 + x)**-offset
    end
    value
  end

  def payment_offset_in_year(date)
    if date.leap?
      payment_offset = (date.yday - 1) / 366.0
    else
      payment_offset = (date.yday - 1) / 365.0
    end
    payment_offset
  end

  def payments_derivative(payments)
    derivative = []
    payments.each do |payment_with_offset|
      amount = payment_with_offset.amount
      offset = payment_with_offset.offset
      derivative << PaymentWithOffset.new(-1 * offset * amount, - (- offset - 1))
    end
    derivative
  end
end
