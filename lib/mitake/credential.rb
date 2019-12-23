# frozen_string_literal: true

require 'mitake/account/point'

module Mitake
  # The Mitake SMS Client
  #
  # @since 0.1.
  class Credential
    # @since 0.1.0
    # @api private
    DEFAULT_SERVER = 'https://smsapi.mitake.com.tw'

    # @since 0.1.0
    attr_reader :username, :password, :server

    # Return Mitake::Client instance
    #
    # @param username [String] the username, default is `MITAKE_USERNAME`
    # @param password [String] the password, default is `MITAKE_PASSWORD`
    # @param server [String] the API server url
    # @return [Mitake::Client] the api instance
    #
    # @since 0.1.0
    def initialize(username = nil, password = nil, server = nil)
      @username = username || ENV['MITAKE_USERNAME']
      @password = password || ENV['MITAKE_PASSWORD']
      @server = server || ENV['MITAKE_SERVER'] || DEFAULT_SERVER
    end
  end
end
