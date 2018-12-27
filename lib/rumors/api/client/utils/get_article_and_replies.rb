module Rumors
  module Api
    module Client
      module Utils
        class GetArticleAndReplies
          def initialize(id)
            @id = id
          end

          def purify_gql_query
            gql_query.strip
          end

          def variables
            { id: "#{@id}" }
          end

          private

          def gql_query
            <<-GQL
            query get_article($id: String) {
                GetArticle(id: $id) {
                    id
                    text
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
            GQL
          end
        end
      end
    end
  end
end
