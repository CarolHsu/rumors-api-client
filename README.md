# Rumors::Api::Client

All credit belongs to [@cofacts](https://github.com/cofacts), appreciate all efforts they have done time to time for the line rumors.

This Ruby api Client which is based on Cofacts database and the provided GraphQL, to let you search high relevant rumor results easily.

Visit [真的假的 Cofacts](https://beta.hackfoldr.org/cofacts), to become one of contributors!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rumors-api-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rumors-api-client

## Usage

```ruby
rumor = "行政院最新公告～元旦放七天嘍！收到這訊息。千萬別點閱，因為有病毒，已有朋友中獎了，請大家告訴大家!如果有收到，元旦放七天，的那個是釣魚網站，別點。"

response = Rumors::Api::Client.search rumor

#=> #<HTTParty::Response:0x7fe0e51731d0 parsed_response={"data"=>{"GetArticle"=>{"id"=>"5394036018554-rumor", "text"=>"行政院最新公告～元旦放七天嘍！收到這訊息。千萬別點閱，因為有病毒，已有朋友中獎了，請大家告訴大家!如果有收到，元旦放七天，的那個是釣魚網站，別點", "articleReplies"=>[{"reply"=>{"id"=>"5361365129457-answer", "text"=>"人事行政總處已確認，明年的元旦假期只有4天假期，顯然說法有明顯出入，且該連結的安全性受到質疑。警政署165專線表示，初步判定該點選連結不會竊取個資，而連結網站惡作劇使用JavaScript產生彈跳視窗，民眾只要關閉就不會出現，並非惡意程式。", "type"=>"RUMOR", "reference"=>"http://www.appledaily.com.tw/realtimenews/article/new/20141209/520844/"}}, {"reply"=>{"id"=>"5394036018554-answer", "text"=>"其實早在兩年前，這樣的訊息就已經開始流傳，165反詐騙專線也證實這是惡作劇網站，初判不會竊取用戶個資。", "type"=>"RUMOR","reference"=>"http://www.setn.com/News.aspx?NewsID=187698"}}, {"reply"=>{"id"=>"AV8UubqFyCdS-nWhuhVz", "text"=>"人事行政總處已確認，明年的元旦假期只有4天假期，顯然說法有明顯出入，且該連結的安全性受到質疑。早在兩年前，這樣的訊息就已經開始流傳，165反詐騙專線也證實這是惡作劇網站，不會竊取用戶個資。警政署165專線表示，而連結網站惡作劇使用JavaScript產生彈跳視窗，民眾只要關閉就不會出現，並非惡意程式。", "type"=>"RUMOR","reference"=>"http://www.appledaily.com.tw/realtimenews/article/new/20141209/520844/\nLINE釣魚訊息瘋傳　元旦放7天係假\n\nhttp://www.setn.com/News.aspx?NewsID=187698\n元旦放7天?"}}]}}}, @response=#<Net::HTTPOK 200 OK readbody=true>, @headers={"server"=>["nginx/1.11.6"], "date"=>["Fri, 21 Dec 2018 07:20:01 GMT"], "content-type"=>["application/json"], "content-length"=>["1725"], "connection"=>["close"], "vary"=>["Origin"], "strict-transport-security"=>["max-age=15768000"]}>"}}]"}}}

response.body
#=> "{\"data\":{\"GetArticle\":{\"id\":\"5394036018554-rumor\",\"text\":\"行政院最新公告～元旦放七天嘍！收到這訊息。千萬別點閱，因為有病毒，已有朋友中獎了，請大家告訴大家!如果有收到，元旦放七天，的那個是釣魚網站，別點\",\"articleReplies\":[{\"reply\":{\"id\":\"5361365129457-answer\",\"text\":\"人事行政總處已確認，明年的元旦假期只有4天假期，顯然說法有明顯出入，且該連結的安全性受到質疑。警政署165專線表示，初步判定該點選連結不會竊取個資，而連結網站惡作劇使用JavaScript產生彈跳視窗，民眾只要關閉就不會出現，並非惡意程式。\",\"type\":\"RUMOR\",\"reference\":\"http://www.appledaily.com.tw/realtimenews/article/new/20141209/520844/\"}},{\"reply\":{\"id\":\"5394036018554-answer\",\"text\":\"其實早在兩年前，這樣的訊息就已經開始流傳，165反詐騙專線也證實這是惡作劇網站，初判不會竊取用戶個資。\",\"type\":\"RUMOR\",\"reference\":\"http://www.setn.com/News.aspx?NewsID=187698\"}},{\"reply\":{\"id\":\"AV8UubqFyCdS-nWhuhVz\",\"text\":\"人事行政總處已確認，明年的元旦假期只有4天假期，顯然說法有明顯出入，且該連結的安全性受到質疑。早在兩年前，這樣的訊息就已經開始流傳，165反詐騙專線也證實這是惡作劇網站，不會竊取用戶個資。警政署165專線表示，而連結網站惡作劇使用JavaScript產生彈跳視窗，民眾只要關閉就不會出現，並非惡意程式。\",\"type\":\"RUMOR\",\"reference\":\"http://www.appledaily.com.tw/realtimenews/article/new/20141209/520844/\\nLINE釣魚訊息瘋傳　元旦放7天係假\\n\\nhttp://www.setn.com/News.aspx?NewsID=187698\\n元旦放7天?\"}}]}}}"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/carolhsu/rumors-api-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rumors::Api::Client project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rumors-api-client/blob/master/CODE_OF_CONDUCT.md).
