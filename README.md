# Effective Interest Rates

## Introduction

The EffectiveInterestRate class provides a `compute` class method for
computing effective interest rates of a stream of payments in a very
general case.

## Payment Streams

A *payment* is a pair (amount, date) consisting of an amount (in
whatever currency) and a date. The amount can be positive or negative.

For example, (-2000, 2015-01-01) represents an amount of -2000
transferred at Jan 01, 2015.

A payment is represented by an instance of the {Payment} class.

A *payment stream* is a collection of payments.

yA payment stream is represented by an instance of the {PaymentStream}
class.

## Relative Payment Streams

Let `(a_m, t_m)` and `(a_n, t_n)` be two payments. A *relative
payment* (with respect to `(a_m, t_m)`) is a pair `(a_n, r_n)` where
`r_n` is the difference between `t_n` and `t_m` expressed in years.

More precisely, `r_n` is computed as follows: Let `t_m` be the `d_m`th
day in year`y_m` and let `t_n` be the `d_n`th day in year `y_n`. (Days
are indexed starting at `0`. Jan 01 is day `0`.)  Let `D(y)` denote
the number of days in year `y`. For a leap year `y`, `D(y)`
is 366. Otherwise, `D(y)` is 365. Then

```
r_n = (y_n - y_m) + (d_n / D(y_n) - d_m / D(y_m)).
```

A relative payment is represented by an instance of the
{RelativePayment} class.

A relative paymnent stream is a collection of relative payments with
respect to the earliest payment in the given payment stream.

A relative payment stream is representd by an instance of the
{RelativePaymentStream} class.

## The Net Present Value Function

Let `[(a_1, t_1), ..., (a_n, t_n)]` be a payment stream. Then the
corresponding relative payment stream `[(a_1, r_1), ..., (a_n, r_n)]`
gives rise to the definition of the net present value function `npv`
of a single real variable `x`.

```
npv(x) = a_1 * (1 + x)^(-r_1) + ... + a_n * (1 + x)^(-r_n)
```

The effective interest rate of the original payment stream is the root
of the `npv` function.

In general, there is no closed formula for the computation of the root
of `npv`.  However, given a "reasonable" start value, Newton's method
converges very fast to the wanted root.

Newton's method requires the compuation of the derivative `npv'` of
`npv`. Fortunately, `npv'` can be easily written in a closed form:

```
npv' = a_1 * (-r_1) * (1 + x)^(-r_1 - 1) + ... + a_n * (-r_n) * (1 + x)^(-r_n - 1)
```

The net present value function and its derivative are required to
approximate the effective interest rate of a payment stream using
Newton's method.

## Effective Interest Rates

The `compute` class method of the `EffectiveInterestRate` class takes
a `PaymentStream` object and returns the effective interest rate of
the payment stream (or `nil` if the effective interest rate cannot be
computed).

### Example

```ruby
payments = [Payment.new(240_000, Date.new(2015, 1, 1))]
(2015..2034).each do |year|
  (1..12).each do |month|
    payments << Payment.new(-1200, Date.new(year, month, 1))
  end
end

effective_interest_rate = EffectiveInterestRate.compute(PaymentStream.new(payments))
```

In this example, a borrower receives 240.000 (units) on January
1, 2015.  For twenty years, the borrower pays the lender 1.200 (units)
on the first of every month.

The borrower received 240.000 (units), the lender gets 20 * 12 * 1.200
(units) = 288.000 (units) back (which implies that there must be a
non-zero effective interest rate).

## Installation

The easiest way to install the required classes is to generate a gem
and use this gem in your application.

```bash
gem build effective_interest_rate.gemspec
gem install effective_interest_rate-0.1.0.gem
```

Add the following line to your application's Gemfile:

```ruby
gem 'effective_interest_rate'

```
and run

```bash
bundle
```
## Tests

Run

```bash
rake test
```

## Documentation

```bash
yard doc
```

should generate a few HTML pages in the `doc` directory.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/michaelkpfeifer/effective-interest-rate-ruby.

## License

The software package is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).
