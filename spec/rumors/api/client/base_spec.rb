RSpec.describe Rumors::Api::Client::Base do
  let(:text) { "2018" }
  subject { Rumors::Api::Client::Base.new(text) }

  describe '#build_body' do
    context 'as list_articles' do
      it 'should return hash with query' do
        body = subject.send(:build_body, 'list_articles', text)
        expected_body = Rumors::Api::Client::Utils::ListArticles.new(text).purify_gql_query
        expect(body[:query]).to eq(expected_body)
      end
    end
  end

  describe '#post_request' do
    context 'with list_articles body' do
      it 'should get related response' do
        VCR.use_cassette('list_articles') do
          body = subject.send(:build_body, 'list_articles', text)
          response = subject.send(:post_request, body)
          expect(response.code).to eq(200)
          parsed_body = JSON.parse(response.body)
          article_ids = parsed_body['data']['ListArticles']['edges'].map do |record|
            record['node']['id']
          end
          expect(article_ids).to match_array %w(5658951254672-rumor AVsaogPGtKp96s659DcD mapwsl4yunp0 1xhezk7x6677d)
        end
      end
    end
  end
end
