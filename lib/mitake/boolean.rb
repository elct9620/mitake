# frozen_string_literal: true

module Mitake
  # The helper object to define boolean value
  #
  # @since 0.1.0
  # @api private
  class Boolean
    TRUE_VALUES = %w[Y 1 yes true].freeze

    class << self
      def parse(value)
        return true if TRUE_VALUES.include?(value)

        false
      end
    end
  end
end
