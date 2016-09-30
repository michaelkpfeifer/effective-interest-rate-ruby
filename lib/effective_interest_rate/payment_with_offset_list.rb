class PaymentPointList
  include Enumerable

  attr_accessor :payment_point_list

  def initialize(payment_list)
    @payment_point_list = []

    first_payment = payment_list.sort.first
    first_payment_date = first_payment.date
    if first_payment_date.leap?
      first_payment_offset = (first_payment_date.yday - 1) / 366.0
    else
      first_payment_offset = (first_payment_date.yday - 1) / 365.0
    end
    first_payment_year = first_payment.date.year

    payment_list.each do |payment|
      payment_date = payment.date
      year_difference = payment_date.year - first_payment_year
      if payment_date.leap?
        offset = (payment_date.yday - 1) / 366.0
      else
        offset = (payment_date.yday - 1) / 365.0
      end
      offset = offset + year_difference - first_payment_offset
      payment_point = PaymentPoint.new(payment.amount, offset)

      @payment_point_list << payment_point
    end
  end

  def each
    @payment_point_list.each do |payment_point|
      yield payment_point
    end
  end

  def size
    @payment_point_list.size
  end
end
