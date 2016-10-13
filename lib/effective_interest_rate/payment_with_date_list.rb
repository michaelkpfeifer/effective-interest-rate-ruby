class PaymentWithDateList
  attr_accessor :payment_with_date_list

  def initialize
    @payment_with_date_list = []
  end

  def <<(payment_with_date)
    @payment_with_date_list << payment_with_date
  end

  def size
    @payment_with_date_list.size
  end

  def min_date
    @payment_with_date_list.min.date
  end

  def max_date
    @payment_with_date_list.max.date
  end
end
