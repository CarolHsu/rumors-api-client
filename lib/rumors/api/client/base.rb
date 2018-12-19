module Rumors
  module Api
    module Client
      class Base
        DATA_HOST = "https://cofacts-api.g0v.tw/graphql?"

        def initialize(text)
          @text = text
        end

        def search
          articles = list_articles
          select_article(articles)
        end

        def list_articles
          body = build_body('list_articles', @text)
          post_request(body)
        end

        private

        def select_article(articles)
          # TODO: get_most_like_article_id
          body = build_body('get_article_and_replies', get_most_like_article_id)
          post_request(body)
        end

        def post_request(body)
          HTTParty.post(
            DATA_HOST,
            body: body.to_json,
            headers: build_headers
          )
        end

        def build_headers
          {
            'Content-Type': 'application/json',
          }
        end

        def build_body(util, argument)
          current_util = "rumors/api/client/utils/#{util}".classify
          {
            query: eval(current_util).new(argument).purify_gql_query,
          }
        end
      end
    end
  end
end

class String
  def classify
    self.split('/').collect do |c|
      c.split('_').collect(&:capitalize).join
    end.join('::')
  end
end
