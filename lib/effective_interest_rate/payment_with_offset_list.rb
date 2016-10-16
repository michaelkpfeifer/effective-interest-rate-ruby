class PaymentWithOffsetList
  attr_accessor :payment_with_offset_list
  attr_accessor :payment_with_offset_list_derivative

  def initialize(payment_with_date_list)
    first_payment_date = payment_with_date_list.min_date
    first_payment_offset = payment_offset_in_year(first_payment_date)
    first_payment_year = first_payment_date.year

    @payment_with_offset_list = []
    payment_with_date_list.payment_with_date_list.each do |payment_with_date|
      payment_with_date_date = payment_with_date.date
      year_difference = payment_with_date_date.year - first_payment_year
      offset = payment_offset_in_year(payment_with_date_date)
      offset = offset + year_difference - first_payment_offset
      payment_with_offset = PaymentWithOffset.new(payment_with_date.amount, offset)
      @payment_with_offset_list << payment_with_offset
    end

    @payment_with_offset_list_derivative = payment_with_offset_list_derivative(@payment_with_offset_list)
  end

  def size
    @payment_with_offset_list.size
  end

  def sorted_offsets
    @payment_with_offset_list.map(&:offset).sort
  end

  def effective_interest_rate
    value = 0.0
    8.times do
      nominator = evaluate(@payment_with_offset_list, value)
      denominator = evaluate(@payment_with_offset_list_derivative, value)
      value = value - (nominator / denominator)
    end

    value
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

  def payment_with_offset_list_derivative(payment_with_offset_list)
    derivative = []
    payment_with_offset_list.each do |payment_with_offset|
      amount = payment_with_offset.amount
      offset = payment_with_offset.offset
      derivative << PaymentWithOffset.new(-1 * offset * amount, - (- offset - 1))
    end
    derivative
  end
end
