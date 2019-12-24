# frozen_string_literal: true

require 'mitake/parser'
require 'mitake/api/get'
require 'mitake/api/post'

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

      # Set response field mapping
      #
      # @param from [String] the response field
      # @param to [String] the target field
      #
      # @since 0.1.0
      # @api private
      def map(from, to)
        @mapping ||= {}
        @mapping[from.to_s] = to.to_s
      end

      # Execute API
      #
      # @param params [Hash] the API params
      # @param _block [Proc] the customize process
      # @return [Mitake::API] the api response
      #
      # @since 0.1.0
      # @api private
      def execute(params = {}, &_block)
        res = request(params)
        raise Mitake::API::Error, res.code unless res.is_a?(Net::HTTPOK)

        items = Parser.new(res).parse.map { |item| rename_attribute(item) }
        return items.map { |item| new(item) } unless block_given?

        yield items
      end

      private

      # Send HTTP Request
      #
      # @return [Net::HTTPResponse] the http response
      #
      # @since 0.1.0
      # @api private
      def request(params = {})
        klass = API.const_get(method)
        klass.new(path, params).execute
      end

      # Rename attributes
      #
      # @param item [Hash] the source hash
      #
      # @since 0.1.0
      # @api private
      def rename_attribute(item)
        item.map do |key, value|
          [@mapping[key] || key, value]
        end.to_h
      end
    end
  end
end
