require "test_helper"

class Agilix::Buzz::ApiTest < Minitest::Test

  describe 'API methods' do

    it "throws an authentication error if bad credentials" do
      VCR.use_cassette("Api authentication error on bad login", match_requests_on: [:query]) do
        bad_api = Agilix::Buzz::Api.new username: 'bad', password: 'test', domain: 'domain'
        assert_raises Agilix::Buzz::Api::AuthenticationError do
          bad_api.check_authentication
        end
      end
    end
  end

end
