class PaymentWithOffsetList
  include Enumerable

  attr_accessor :payment_with_offset_list

  def initialize(payment_with_date_list)
    @payment_with_offset_list = []

    first_payment_with_date = payment_with_date_list.sort.first
    first_payment_with_date_date = first_payment_with_date.date
    if first_payment_with_date_date.leap?
      first_payment_with_offset = (first_payment_with_date_date.yday - 1) / 366.0
    else
      first_payment_with_offset = (first_payment_with_date_date.yday - 1) / 365.0
    end
    first_payment_year = first_payment_with_date.date.year


    payment_with_date_list.each do |payment_with_date|
      payment_with_date_date = payment_with_date.date
      year_difference = payment_with_date_date.year - first_payment_year
      if payment_with_date_date.leap?
        offset = (payment_with_date_date.yday - 1) / 366.0
      else
        offset = (payment_with_date_date.yday - 1) / 365.0
      end
      offset = offset + year_difference - first_payment_with_offset
      payment_with_offset = PaymentWithOffset.new(payment_with_date.amount, offset)

      @payment_with_offset_list << payment_with_offset
    end
  end

  def each
    @payment_with_offset_list.each do |payment_with_offset|
      yield payment_with_offset
    end
  end

  def size
    @payment_with_offset_list.size
  end
end
