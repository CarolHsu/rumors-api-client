RSpec.describe Rumors::Api::Client::Base do
  let(:text) { "2018" }
  subject { Rumors::Api::Client::Base.new(text) }

  describe '#search' do
    let(:rumor) do
      <<-RUMOR
      (jk)我是JK郭，約三年前看到（全天一直喝40度C以上，不超過50 度C熱開水）即能不患癌的文章後，從此堅持下去，因為我相信。
      (red arrow right)這兩三年來發覺自己更健康了，因此這二年多來也不斷對周邊的長輩、親友、學生傳達這個理念和訊息。
      (red arrow right)今天又收到一位宗兄傳來完全相同的訊息，決定將此人類無價之寶（健康寶典）寄給我所有的長輩、親友、師長、學生們⋯⋯，請大家一定要看完，多看幾次，也一定要效法做到，堅持從此不再飲食恆溫或冰品（冰品冷飲是癌細胞的維他命）記得要時時喝熱開水，讓體內溫度經常升高在40度C～45度C左右（比體溫高3～5度），這是三年來我一直堅持的鐵原則！ 好處多多！
      (red arrow right)我長期自己帶800CC的（304不銹鋼）保溫瓶，絕對不飲食不夠40度C以上的湯水！
      (red arrow right)經常看到很多很多人喝塑膠瓶磺泉水，冰塊冷飲，尤其是年輕人都習慣成自然了，沒有一杯冰塊冷欽就吃不下飯似的，殊不知傷害健康有多嚴重，我想他她們喝下冰品下肚覺得好爽，就連吃飯中舉手一口冰塊冷飲真的好爽！可知道嗎，體內癌細胞也好爽好爽呀！
      (red arrow right)現在再一次廣傳這：德國、美國、日本專家提出殺死癌細胞的「新方法」！竟然如此簡單！卻是很少人肯相信。(doh!)(!)
      (red arrow right)殺死癌細胞原來就是經常喝這個！人人都可輕易輕鬆做到啦(!)(!)(!)
      (red arrow right)也請您傳給所有認識的親友們(!)感恩(!)
      (pink flower)祝福大家永遠健康快樂(!)
      (red arrow right)：http://youtu.be/Htyi-LVTV-M
      RUMOR
    end

    subject { Rumors::Api::Client::Base.new(rumor) }

    it 'should search the most high relevant article and replies' do
      VCR.use_cassette('article_integration_test') do
        response = subject.search
        expect(response.keys).to eq(%w(id text articleReplies))
      end
    end
  end

  describe '#build_body' do
    context 'as list_articles' do
      it 'should return hash with query' do
        body = subject.send(:build_body, 'list_articles', text)
        expected_body = Rumors::Api::Client::Utils::ListArticles.new(text).purify_gql_query
        expect(body[:query]).to eq(expected_body)
      end
    end
  end

  describe 'calculate_similarity' do
    let(:rumor) do
      "全台首家獲得 Google 新聞 雙認證 二線電子新聞媒體，並列全台主流媒體新聞群，正式即時推播上線！兩岸報導 Google新聞（國際）認證獨立版 https://goo.gl/Jj5bWK一線版 https://goo.gl/6Ntguf八方新聞  Google新聞（地方）認證獨立版 https://goo.gl/kDetd7一線版 https://goo.gl/nzemyZ歡迎舊雨新知繼續支持～"
    end

    before :each do
      VCR.use_cassette('list_articles') do
        body = subject.send(:build_body, 'list_articles', text)
        response = subject.send(:post_request, body)
        subject.instance_variable_set(:@text, rumor)
        subject.instance_variable_set(:@articles, response)
      end
    end

    it 'should return most similar article_id and score' do
      contents = subject.send(:parse_content)
      most_like = subject.send(:calculate_similarity, contents)
      expect(most_like[:article_id]).to eq('1xhezk7x6677d')
    end
  end

  describe '#return_article' do
    before :each do
      allow(subject).to receive(:parse_content)
    end

    context 'score <= 0.8' do
      let(:article_id) { 'AVqR8SZlyrDaTqlmmp9Z' }
      before :each do
        rank = { article_id: article_id, score: 0.8 }
        allow(subject).to receive(:calculate_similarity).and_return(rank)
      end

      it 'should not get article' do
        response = subject.send(:return_article)
        expect(response).to be_nil
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
          response_body = parsed_body(response)
          article_ids = response_body['data']['ListArticles']['edges'].map do |record|
            record['node']['id']
          end
          expect(article_ids).to match_array %w(5658951254672-rumor AVsaogPGtKp96s659DcD mapwsl4yunp0 1xhezk7x6677d)
        end
      end
    end
  end
end

def parsed_body(response)
  JSON.parse(response.body)
end
