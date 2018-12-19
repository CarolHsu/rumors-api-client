module Rumors
  module Api
    module Client
      class Base
        DATA_HOST = "https://cofacts-api.g0v.tw/graphql?"
        SIMILARITY = 8.0

        def initialize(text)
          @text = text
        end

        def search
          @articles = list_articles
          return_article
        end

        def list_articles
          body = build_body('list_articles', @text)
          post_request(body)
        end

        private

        def return_article
          contents = parse_content
          most_like = calculate_similarity(contents)
          return unless most_like[:score] > SIMILARITY
          body = build_body('get_article_and_replies', most_like[:article_id])
          post_request(body)
        end

        def parse_content
          parsed_articles = JSON.parse(@articles)
          parsed_articles['data']['ListArticles']['edges'].map do |article|
            node = article['node']
            Hash[node['id'], node['text']]
          end
        end

        def calculate_similarity(contents)
          # NOTE: https://github.com/jpmckinney/tf-idf-similarity
          most_like = {
            article_id: '',
            score: 0,
          }

          original_text = TfIdfSimilarity::Document.new(@text)

          corpus = [original_text]

          contents.each do |id, text|
            eval("#{id} = TfIdfSimilarity::Document.new(#{text})")
            corpus << eval(id)
          end

          model = TfIdfSimilarity::TfIdfModel.new(corpus)
          matrix = model.similarity_matrix

          contents.keys.each do |article_id|
            score = matrix[model.document_index(original_text), model.document_index(eval(article_id))]
            next unless score > most_like['score']

            most_like[:article_id] = article_id
            most_like[:score] = score
          end

          most_like
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
