# frozen_string_literal: true

# The NewtonIteration class implements the computation of roots of
# real functions using Newton's method.
class NewtonIteration
  # Runs Newton's iteration
  #
  # The +max_iteration_difference+ and +max_iterations+ parameters are
  # used to terminate the iteration process.
  #
  # If the absolute value of the difference between two consecutive
  # values produced by the iteration process is smaller than
  # +max_iteration_difference+, then the last value produced by the
  # iteration process is returned.
  #
  # If the absolute values of the difference between two consecutive
  # values after +max_iterations+ iterations is still larger than
  # +max_iteration_difference+, then +nil+ is returned.
  #
  # @param f [Proc] the function whose root is to be determined
  # @param fp [Proc] the derivative of the function whose root is to
  #   be determined
  # @param start_value [Float] the first value to be used in the
  #   iteration process, usually a guess where the root may be located
  # @param max_iteration_difference [Float] maximum difference between
  #   two iterations
  # @param max_iterations [Integer] maximum number of iterations
  # @return [Float, nil] an approximation of the root of the given
  #   function or +nil+ if an approximation for a root could not be
  #   found
  def self.iterate(f, fp, start_value, max_iteration_difference, max_iterations)
    iteration_count = 0
    previous_iteration = start_value

    loop do
      return nil if iteration_count > max_iterations

      iteration = previous_iteration - f.call(previous_iteration) / fp.call(previous_iteration)

      return iteration if (iteration - previous_iteration).abs <= max_iteration_difference

      iteration_count += 1
      previous_iteration = iteration
    end
  end
end
