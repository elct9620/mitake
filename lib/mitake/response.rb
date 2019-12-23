# frozen_string_literal: true

require 'mitake/api'

module Mitake
  # The API response
  #
  # @since 0.1.0
  class Response
    include API

    method 'Post'
    path '/api/mtk/SmSend?CharsetURL=UTF8'

    # @since 0.1.0
    # @api private
    def initialize(_response)
      # TODO: Process API response
    end
  end
end
