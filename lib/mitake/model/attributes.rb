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
          send("#{key}=", value)
        end
      end
    end
  end
end
