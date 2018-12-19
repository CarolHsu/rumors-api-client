RSpec.describe Rumors::Api::Client::Utils::ListArticles do
  let(:text) { "2018" }
  subject { Rumors::Api::Client::Utils::ListArticles.new(text) }

  describe '.gql_query' do
    it 'should build expected query string' do
      gql_query_string = subject.purify_gql_query
      expect(gql_query_string).to match(/ListArticles/)
      expect(gql_query_string).to match(/filter/)
      expect(gql_query_string).to match(/orderBy/)
      expect(gql_query_string).to match(/first/)
      expect(gql_query_string).to match(/edges/)
      expect(gql_query_string).to match(/node/)
      expect(gql_query_string).to match(/id/)
      expect(gql_query_string).to match(/text/)
    end
  end
end
