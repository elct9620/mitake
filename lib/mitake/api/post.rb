# frozen_string_literal: true

require 'mitake/api/base'

module Mitake
  module API
    # Create HTTP Get Request
    #
    # @since 0.1.0
    # @api private
    class Post < Base
      # Create HTTP Post Request
      #
      # @since 0.1.0
      # @api private
      def request
        return @request unless @request.nil?

        @request ||= Net::HTTP::Post.new(uri)
        @request.body = URI.encode_www_form(params)
        @request
      end
    end
  end
end
