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

    # Assign attribute by hash
    #
    # @see Mitake::Model::Attributes#assign_attributes
    #
    # @param attributes [Hash] the attributes to assignment
    #
    # @since 0.1.0
    def assign_attributes(attributes = {})
      attributes.each do |key, value|
        next unless self.class.attribute_names.include?(key.to_s)
        next send("#{key}=", value) if respond_to?("#{key}=")

        type = self.class.attributes[key.to_s]
        instance_variable_set("@#{key}", self.class.cast(value, type))
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
        .attribute_names
        .map { |attr| [attr, send(attr)] }
        .reject { |_, value| value.nil? }
        .map do |attr, value|
        [attr, value.respond_to?(:attributes) ? value.attributes : value]
      end
        .to_h
    end
  end
end
