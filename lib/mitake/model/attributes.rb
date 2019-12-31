# frozen_string_literal: true

module Mitake
  module Model
    # @since 0.1.0
    # @api private
    module Attributes
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
          next unless self.class.attribute_names.include?(key.to_s)
          next send("#{key}=", value) if respond_to?("#{key}=")

          type = self.class.attributes[key.to_s]
          instance_variable_set("@#{key}", self.class.cast(value, type))
        end
      end
    end
  end
end
