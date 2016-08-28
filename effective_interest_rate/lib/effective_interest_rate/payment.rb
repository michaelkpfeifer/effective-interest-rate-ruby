class Payment
  attr_accessor :amount
  attr_accessor :date

  def initialize(amount, date)
    @amount = amount
    @date = date
  end
end
