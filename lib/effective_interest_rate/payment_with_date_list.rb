class PaymentWithDateList
  include Enumerable

  attr_accessor :payment_with_date_list

  def initialize
    @payment_with_date_list = []
  end

  def each
    @payment_with_date_list.each do |payment_with_date|
      yield payment_with_date
    end
  end

  def <<(payment_with_date)
    @payment_with_date_list << payment_with_date
  end

  def size
    @payment_with_date_list.size
  end
end
