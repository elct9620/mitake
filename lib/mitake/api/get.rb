# frozen_string_literal: true

require 'mitake/api/base'

module Mitake
  module API
    # Create HTTP Get Request
    #
    # @since 0.1.0
    # @api private
    class Get < Base
      # Create HTTP Get Request
      #
      # @since 0.1.0
      # @api private
      def request
        return @request unless @request.nil?

        @request ||= Net::HTTP::Get.new(uri)
      end

      # @see Mitake::API::Base#uri
      #
      # @since 0.1.0
      # @api private
      def uri
        @uri ||=
          URI("#{Mitake.credential.server}" \
              "#{@path}?#{URI.encode_www_form(params)}")
      end
    end
  end
end
