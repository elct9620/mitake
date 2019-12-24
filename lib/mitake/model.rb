# frozen_string_literal: true

require 'mitake/model/attributes'
require 'mitake/model/accessor'

module Mitake
  # Provide attributes accessor
  #
  # @since 0.1.0
  # @api private
  module Model
    # @since 0.1.0
    # @api private
    def self.included(base)
      base.class_eval do
        include Attributes
        extend Accessor
      end
    end

    # Get attributes as hash
    #
    # @return [Hash] the object attributes
    #
    # @since 0.1.0
    def attributes
      self
        .class
        .attributes
        .map { |attr| [attr, send(attr)] }
        .reject { |_, value| value.nil? }
        .map do |attr, value|
          [attr, value.respond_to?(:attributes) ? value.attributes : value]
        end
        .to_h
    end
  end
end
