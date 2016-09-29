class PaymentPoint
  include Comparable

  attr_accessor :amount
  attr_accessor :offset

  def initialize(amount, offset)
    @amount = amount
    @offset = offset
  end

  def <=>(other)
    self.offset <=> other.offset
  end
end
