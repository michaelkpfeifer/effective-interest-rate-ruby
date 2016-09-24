class PaymentList
  attr_accessor :payment_list

  def initialize
    @payment_list = []
  end

  def each
    @payment_list.each do |payment|
      yield payment
    end
  end

  def <<(payment)
    @payment_list << payment
  end

  def size
    payment_list.size
  end

  def min_date
    @payment_list.sort.first.date
  end

  def max_date
    @payment_list.sort.last.date
  end
end
