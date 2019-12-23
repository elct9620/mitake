# frozen_string_literal: true

require 'mitake/model'
require 'mitake/recipient'
require 'mitake/response'

module Mitake
  # Create Sort Message
  #
  # @since 0.1.0
  class Message
    include Model

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

    # Send message
    #
    # @since 0.1.0
    # @api private
    def delivery
      return if @sent

      # TODO: Rename `Response`
      Response.execute(params)
    ensure
      @sent = true
    end

    private

    # The request params
    #
    # @since 0.1.0
    # @api private
    def params
      {
        clientid: @id,
        smbody: @body,
        dlvtime: @schedule_at&.strftime('%Y%m%d%H%M%S'),
        vldtime: @expired_at&.strftime('%Y%m%d%H%M%S'),
        dstaddr: @recipient.phone_number,
        destname: @recipient.name
      }.reject { |_, v| v.nil? }.to_h
    end
  end
end
