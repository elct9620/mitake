# frozen_string_literal: true

require 'mitake/version'
require 'mitake/credential'
require 'mitake/balance'
require 'mitake/message'

# The Mitake API Client
#
# @since 0.1.0
module Mitake
  # @since 0.1.0
  # @api private
  LOCK = Mutex.new

  # Switch credential
  #
  # @param credential [Mitake::Credential] the api credential
  # @param _block [Proc] the actions use specify credential
  #
  # @since 0.1.0
  def self.use(credential, &_block)
    temp = credential
    LOCK.synchronize do
      self.credential = credential
      yield
      self.credential = temp
    end
  end

  # The credential
  #
  # @return [Mitake::Credential] the current credential
  #
  # @since 0.1.0
  def self.credential
    @credential ||= Credential.new
  end

  # Set credential
  #
  # @param credential [Mitake::Credential] the new credential
  #
  # @since 0.1.0
  def self.credential=(credential)
    @credential = credential
  end
end
