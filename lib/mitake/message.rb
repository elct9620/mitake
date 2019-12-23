# frozen_string_literal: true

require 'mitake/api'
require 'mitake/model'
require 'mitake/recipient'

module Mitake
  # Create Sort Message
  #
  # @since 0.1.0
  class Message
    include API
    include Model

    method 'Post'
    path '/api/mtk/SmSend'

    # @since 0.1.0
    attribute :id, String
    attribute :recipient, Recipient
    attribute :body, String
    attribute :schedule_at, Time
    attribute :expired_at, Time

    # Create a new mesage
    #
    # @return [Mitake::Message]
    #
    # @since 0.1.0
    def initialize(attributes = {})
      super
      @sent = false
    end
  end
end
