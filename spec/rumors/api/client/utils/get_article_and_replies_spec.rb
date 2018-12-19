RSpec.describe Rumors::Api::Client::Utils::GetArticleAndReplies do
  let(:id) { "2018" }
  subject { Rumors::Api::Client::Utils::GetArticleAndReplies.new(id) }

  describe '.gql_query' do
    it 'should build expected query string' do
      gql_query_string = subject.purify_gql_query
      expect(gql_query_string).to match(/GetArticle/)
      expect(gql_query_string).to match(/id/)
      expect(gql_query_string).to match(/text/)
      expect(gql_query_string).to match(/articleReplies/)
      expect(gql_query_string).to match(/reply/)
      expect(gql_query_string).to match(/type/)
      expect(gql_query_string).to match(/reference/)
    end
  end
end
