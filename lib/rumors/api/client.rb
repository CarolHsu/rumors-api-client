# frozen_string_literal: true
require "httparty"
require "json"
require "rumors/api/client/version"
require "rumors/api/client/base"
require "rumors/api/client/utils/list_articles"

module Rumors
  module Api
    module Client
      def self.search(text)
        Rumors::Api::Client::Base.new(text).search
      end
    end
  end
end
