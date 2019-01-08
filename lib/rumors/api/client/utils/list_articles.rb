module Rumors
  module Api
    module Client
      module Utils
        class ListArticles
          def initialize(text)
            @text = text
          end

          def purify_gql_query
            gql_query.strip
          end

          def variables
            { text: @text.to_s }
          end

          private

          def gql_query
            <<~GQL
            query($text: String) {
              ListArticles(
                filter: { moreLikeThis: { like: $text } }
                orderBy: [{ _score: DESC }]
                first: 4
              ) {
                edges {
                  node {
                    id
                    text
                    hyperlinks {
                      url
                    }
                    articleReplies {
                      reply {
                        id
                        text
                        type
                        reference
                      }
                    }
                  }
                }
              }
            }
            GQL
          end
        end
      end
    end
  end
end
