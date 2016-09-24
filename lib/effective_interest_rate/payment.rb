class Payment
  include Comparable

  attr_accessor :amount
  attr_accessor :date

  def initialize(amount, date)
    @amount = amount
    @date = date
  end

  def <=>(other)
    self.date <=> other.date
  end
end
