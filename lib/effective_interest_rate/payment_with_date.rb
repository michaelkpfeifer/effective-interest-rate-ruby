class PaymentWithDate
  include Comparable

  attr_accessor :amount
  attr_accessor :date

  def initialize(amount, date)
    @amount = amount
    @date = date
  end

  def <=>(other)
    @date <=> other.date
  end
end
