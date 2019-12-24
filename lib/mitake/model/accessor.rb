# frozen_string_literal: true

require 'time'
require 'date'

module Mitake
  module Model
    # @since 0.1.0
    # @api private
    module Accessor
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
      # @param _type [Class] the attribute type
      #
      # @since 0.1.0
      def attribute(name, type = 'String')
        @attributes ||= []
        @attributes << name.to_s

        define_method name do
          instance_variable_get("@#{name}")
        end

        define_method "#{name}=" do |value|
          # TODO: Implement type cast
          instance_variable_set("@#{name}", self.class.cast(value, type.to_s))
        end
      end

      # Casting type
      #
      # @param value [Object] the source value
      # @param type [Class] the cast type
      #
      # @since 0.1.0
      # @api private
      def cast(value, type = 'String')
        case type.to_s
        when 'String', 'Integer', 'Float'
          Kernel.method(type).call(value)
        when 'Time', 'DateTime', 'Date'
          Kernel.const_get(type).parse("#{value}+8")
        else
          klass = Kernel.const_get(type)
          return klass.parse(value) if klass.respond_to?(:parse)

          value
        end
      end
    end
  end
end
