# frozen_string_literal: true
require "matrix"
require "tf-idf-similarity"
require "httparty"
require "json"
require "rumors/api/client/version"
require "rumors/api/client/base"
require "rumors/api/client/utils/list_articles"
require "rumors/api/client/utils/get_article_and_replies"

module Rumors
  module Api
    module Client
      def self.search(text)
        Rumors::Api::Client::Base.new(text).search
      end
    end
  end
end
