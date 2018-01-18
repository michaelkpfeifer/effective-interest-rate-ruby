class PaymentWithOffset
  include Comparable

  attr_reader :amount
  attr_reader :offset

  def initialize(amount, offset)
    self.amount = amount
    self.offset = offset
  end

  def <=>(other)
    offset <=> other.offset
  end

  private

  attr_writer :amount
  attr_writer :offset
end
