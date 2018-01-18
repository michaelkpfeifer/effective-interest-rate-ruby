class PaymentWithDate
  include Comparable

  attr_reader :amount
  attr_reader :date

  def initialize(amount, date)
    self.amount = amount
    self.date = date
  end

  def <=>(other)
    date <=> other.date
  end

  private

  attr_writer :amount
  attr_writer :date
end
