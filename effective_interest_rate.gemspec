# -*- ruby -*-

Gem::Specification.new do |s|
  s.name = "effective_interest_rate"
  s.version = "0.0.0"
  s.date = "2017-01-17"
  s.summary = "Compute effective interest rate"
  s.description = "Compute effective interest rates in very general situations."
  s.authors = ["Michael Pfeifer"]
  s.email = ["michael.k.pfeifer@googlemail.com"]
  s.files = ["Rakefile",
             "lib/effective_interest_rate.rb",
             "lib/effective_interest_rate/effective_interest_rate_calculator.rb",
             "lib/effective_interest_rate/payment_with_date.rb",
             "lib/effective_interest_rate/payment_with_offset.rb",
             "test/test_effective_interest_rate_calculator.rb",
             "test/test_helper.rb",
             "test/test_payment_with_date.rb",
             "test/test_payment_with_offset.rb"]
  s.homepage = "http://rubygems.org/effective_interest_rate"
  s.license = "MIT"
end
