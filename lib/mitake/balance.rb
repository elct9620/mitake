# frozen_string_literal: true

require 'mitake/api'
require 'mitake/model'

module Mitake
  # Get the current balance
  #
  # @since 0.1.0
  class Balance
    class << self
      # Get account point
      #
      # @see Mitake::Balance#amount
      # @return [Integer]
      #
      # @since 0.1.0
      def amount
        execute&.first&.amount
      end
    end

    include API
    include Model

    path '/api/mtk/SmQuery'
    map 'AccountPoint', 'amount'

    # @!attribute [r] amount
    # @return [Integer] the amount of account point
    #
    # @since 0.1.0
    attribute :amount, Integer
  end
end
