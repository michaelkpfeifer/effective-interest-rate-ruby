class PaymentList
  include Enumerable

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
    @payment_list.size
  end
end
