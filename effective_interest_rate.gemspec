# frozen_string_literal: true

# -*- ruby -*-

Gem::Specification.new do |s|
  s.name = 'effective_interest_rate'
  s.version = '0.1.0'
  s.date = '2020-08-20'
  s.summary = 'Compute effective interest rates'
  s.description = 'Compute effective interest rates in very general situations.'
  s.authors = ['Michael Pfeifer']
  s.email = ['michael.k.pfeifer@googlemail.com']
  s.files = ['Rakefile',
             'lib/effective_interest_rate.rb',
             'lib/effective_interest_rate/payment.rb',
             'lib/effective_interest_rate/relative_payment.rb',
             'lib/effective_interest_rate/payment_stream.rb',
             'lib/effective_interest_rate/relative_payment_stream.rb',
             'lib/effective_interest_rate/newton_iteration.rb',
             'lib/effective_interest_rate/effective_interest_rate.rb',
             'test/test_helper.rb',
             'test/test_payment.rb',
             'test/test_relative_payment.rb',
             'test/test_payment_stream.rb',
             'test/test_relative_payment_stream.rb',
             'test/test_newton_iteration.rb',
             'test/test_effective_interest_rate.rb']
  s.required_ruby_version = '~> 2.4'
  s.license = 'MIT'
end
