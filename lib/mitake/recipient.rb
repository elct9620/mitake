# frozen_string_literal: true

require 'mitake/model'

module Mitake
  # The recipient
  #
  # @since 0.1.0
  class Recipient
    include Model

    # @since 0.1.0
    attribute :name, String
    attribute :phone_number, String
  end
end
