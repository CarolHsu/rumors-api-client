RSpec.describe Rumors::Api::Client do
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

  it "has a version number" do
    expect(Rumors::Api::Client::VERSION).not_to be nil
  end

  it "get result" do
    VCR.use_cassette('article_integration_test') do
      response = Rumors::Api::Client.search(rumor)
      expect(response.code).to eq(200)
    end
  end
end
