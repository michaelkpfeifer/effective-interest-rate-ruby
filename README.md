# Effective Interest Rates

## Introduction

The EffectiveInterestRateCalculator class provides a method for
computing effective interest rates of a series of payments in a very
general case.

## Installation

The simplest way to install the required classes is to generate a gem
and use this gem in your application.

    $ gem build effective_interest_rate.gemspec
    $ gem install effective_interest_rate-0.0.2.gem

Add the following line to your application's Gemfile:

```ruby
gem 'effective_interest_rate'

```
And then execute:

    $ bundle

## Usage

PaymentWithDate objects represent payments together with a date. Such
payments with dates are fed into the effective interest rate
calculator which finally returns the effective interest rate for the
given series of payments.

    $ irb
    require 'effective_interest_rate'
    eirc = EffectiveInterestRateCalculator.new
    eirc << PaymentWithDate.new(-2000, Date.new(2015, 1, 1))
    eirc << PaymentWithDate.new(1000, Date.new(2016, 1, 1))
    eirc << PaymentWithDate.new(1000, Date.new(2017, 1, 1))
    eirc << PaymentWithDate.new(200, Date.new(2017, 1, 1))
    eirc.effective_interest_rate
    => 0.06394102980498531

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/michaelkpfeifer/effective-interest-rate-ruby.

## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).
