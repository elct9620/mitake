# frozen_string_literal: true

module Mitake
  # Parse API response
  #
  # @since 0.1.0
  # @api private
  class Parser
    # @since 0.1.0
    ID_MATCHER = /\[(\d+)\]/.freeze

    # @since 0.1.0
    attr_reader :items

    # @since 0.1.0
    # @api private
    def initialize(response)
      @response = response
      @body = response.body
      @items = []
    end

    # TODO: Improve response parser
    #
    # @since 0.1.0
    # @api private
    def parse
      @body.each_line do |line|
        next new_item(Regexp.last_match(1)) if line =~ ID_MATCHER

        key, value = line.strip.split('=')
        next if key.nil?

        current[key] = value
      end
      @items << current
    end

    private

    # The current response object
    #
    # @since 0.1.0
    # @api private
    def current
      @current ||= {}
    end

    # Create new response object
    #
    # @param id [String] the clientID
    #
    # @since 0.1.0
    # @api private
    def new_item(id = nil)
      @items << @current unless @current.nil?
      @current = id ? { 'source_id': id } : {}
    end
  end
end
