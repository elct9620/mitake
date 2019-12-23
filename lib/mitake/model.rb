# frozen_string_literal: true

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
        extend ClassMethods
      end
    end

    # @since 0.1.0
    # @api private
    def initialize(attributes = {})
      assign_attributes(attributes)
    end

    # Assign attribute by hash
    #
    # @param attributes [Hash] the attributes to assignment
    #
    # @since 0.1.0
    def assign_attributes(attributes = {})
      attributes.each do |key, value|
        send("#{key}=", value)
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

    # @since 0.1.0
    # @api private
    module ClassMethods
      # Get attributes
      #
      # @return [Array] the list of attributes
      #
      # @since 0.1.0
      def attributes
        @attributes ||= []
      end

      # Define attribute
      #
      # @param name [String|Symbol] the attribute name
      # @param type [Class] the attribute type
      #
      # @since 0.1.0
      def attribute(name, _type = String)
        @attributes ||= []
        @attributes << name

        define_method name do
          instance_variable_get("@#{name}")
        end

        define_method "#{name}=" do |value|
          # TODO: Implement type cast
          instance_variable_set("@#{name}", value)
        end
      end
    end
  end
end
