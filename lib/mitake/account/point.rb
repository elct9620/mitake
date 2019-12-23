# frozen_string_literal: true

require 'mitake/api'

module Mitake
  module Account
    # Current account point
    #
    # @since 0.1.0
    class Point
      include API

      path '/api/mtk/SmQuery'

      attr_reader :value

      # @since 0.1.0
      def initialize(response)
        _, amount = response.body.split('=')
        @value = amount.to_i
      end
    end
  end
end
