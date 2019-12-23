# frozen_string_literal: true

require 'net/http'
require 'mitake/credential'

module Mitake
  module API
    # @since 0.1.0
    # @api private
    class Base
      # @param path [String] the api endpoint
      # @param params [Hash] the request body
      #
      # @since 0.1.0
      # @api private
      def initialize(path, params = {})
        @path = path
        @params = params
      end

      # @since 0.1.0
      # @api private
      def request
        raise NotImplementedError, 'Request not defined!'
      end

      # Execute HTTP Request
      #
      # @return [Net::HTTPResponse] the request result
      #
      # @since 0.1.0
      # @api private
      def execute
        Net::HTTP.start(uri.host, uri.port, use_ssl: ssl?) do |http|
          http.request request
        end
      end

      # @return [URI] the request URI
      #
      # @since 0.1.0
      # @api private
      def uri
        @uri ||= URI("#{Mitake.credential.server}#{@path}")
      end

      # @return [TrueClass|FalseClass] is the SSL request
      #
      # @since 0.1.0
      # @api private
      def ssl?
        @uri.scheme == 'https'
      end

      # Return the request params
      #
      # @return [Hash] the query params
      #
      # @since 0.1.0
      # @api private
      def params
        @params.merge(
          username: Mitake.credential.username,
          password: Mitake.credential.password
        )
      end
    end
  end
end
