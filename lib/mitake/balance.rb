# frozen_string_literal: true

require 'forwardable'

require 'mitake/api'

module Mitake
  # Get the current balance
  #
  # @since 0.1.0
  class Balance
    class << self
      extend Forwardable

      delegate %i[amount] => :execute
    end

    include API

    path '/api/mtk/SmQuery'

    attr_reader :amount

    # @since 0.1.0
    def initialize(response)
      _, amount = response.body.split('=')
      @amount = amount.to_i
    end
  end
end
