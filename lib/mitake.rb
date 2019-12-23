# frozen_string_literal: true

require 'mitake/version'
require 'mitake/credential'

# :nodoc:
module Mitake
  # TODO: Initialize by user
  def self.credential
    @credential = Credential.new
  end
end
