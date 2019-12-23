# frozen_string_literal: true

require 'mitake/api/get'

module Mitake
  # Provide API Interface
  #
  # @since 0.1.0
  # @api private
  module API
    class Error < RuntimeError; end

    # @since 0.1.0
    # @api private
    def self.included(base)
      base.class_eval do
        @method = 'Get'

        extend ClassMethods
      end
    end

    # @since 0.1.0
    # @api private
    module ClassMethods
      # Set/Get the api path
      #
      # @param path [String] the api endpoint path
      # @return [String] if path not given, return previous value
      #
      # @since 0.1.0
      # @api private
      def path(path = nil)
        return @path if path.nil?

        @path = path
      end

      # Set/Get the api method
      #
      # @param method [String] the api request method
      # @return [String] if method not given, return previous value
      #
      # @since 0.1.0
      # @api private
      def method(method = nil)
        return @method if method.nil?

        @method = method.to_s.capitalize
      end

      # Execute API
      #
      # @param client [Mitake::Client] the mitake client
      # @param params [Hash] the API params
      # @return [Mitake::API] the api response
      #
      # @since 0.1.0
      # @api private
      def execute(params = {})
        klass = API.const_get(method)
        res = klass.new(path, params).execute
        return new(res) if res.is_a?(Net::HTTPOK)

        # TODO: Improve error message
        raise Mitake::API::Error, res.code
      end
    end
  end
end
