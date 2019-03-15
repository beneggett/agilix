require "test_helper"

class Agilix::Buzz::Commands::AuthenticationTest < Minitest::Test

  describe "#login2" do
    it "logs in a user" do
      VCR.use_cassette("Commands::Authentication login", match_requests_on: [:query]) do
        username = ENV.fetch("AGILIX_BUZZ_USERNAME", 'your-username')
        password = ENV.fetch("AGILIX_BUZZ_PASSWORD", 'your-password')
        domain   = ENV.fetch("AGILIX_BUZZ_DEFAULT_DOMAIN", 'your-domain')
        response = api.login username: username, password: password, domain: domain
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        assert_equal username, response.dig("response", "user", "username")
        assert_equal domain, response.dig("response", "user", "userspace")
        assert response.dig("response", "user", "token")
      end
    end
  end

  describe "#logout" do
    it "logs out a user" do
      VCR.use_cassette("Commands::Authentication logout", match_requests_on: [:query]) do
        api.check_authentication
        assert api.token
        assert api.token_expiration
        response = api.logout
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        refute api.token
        refute api.token_expiration
      end
    end
  end

  describe "#extend_session" do
    it "extends the token expiration on a users session" do
      VCR.use_cassette("Commands::Authentication extend_session", match_requests_on: [:query]) do
        api.check_authentication
        assert exp1 = api.token_expiration
        response = api.extend_session
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        refute_equal exp1, api.token_expiration
      end
    end
  end

  describe "#force_password_change" do
    it "forces a user to change their password" do
      VCR.use_cassette("Commands::Authentication force_password_change #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.force_password_change userid: TEST_USER_ID
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#get_password_login_attempt_history" do
    it "shows login attempt history for a user" do
      VCR.use_cassette("Commands::Authentication get_password_login_attempt_history #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.get_password_login_attempt_history userid: TEST_USER_ID, earliestrecordtoreturn: '2018-01-01'
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        attempts = response.dig("response", "passwordloginattemptrecords", "passwordloginattemptrecord")
        assert_kind_of Array, attempts
        assert_equal TEST_USER_ID.to_i, attempts.sample["userid"] if attempts.any?
      end
    end
  end

  describe "#get_password_policy" do
    it "looks up a password policy for a domain" do
      VCR.use_cassette("Commands::Authentication get_password_policy #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_password_policy domainid: TEST_DOMAIN_ID
        assert response.success?
        policy = response.dig("response", "passwordpolicy")
        assert_kind_of Hash, policy
        assert_equal 9, policy["minimumlength"]
      end
    end
  end

  describe "#update_password_question_answer" do
    it "updates a password question/answer for a user" do
      VCR.use_cassette("Commands::Authentication update_password_question_answer #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.update_password_question_answer userid: TEST_USER_ID, passwordquestion: "Where is your favorite vacation place?", passwordanswer: "Hawaii"
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#get_password_question" do
    it "looks up a password question for a user" do
      VCR.use_cassette("Commands::Authentication update_password_question_answer #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.get_password_question username: "auto-tests/BuzzUserUp1"
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        assert_equal "Where is your favorite vacation place?", response.dig("response", "question", "$value")
      end
    end
  end

  describe "#put_key" do
    it "stores a key value secret on a domain" do
      VCR.use_cassette("Commands::Authentication put_key secret_key_1", match_requests_on: [:query]) do
        response = api.put_key entityid: TEST_DOMAIN_ID, name: "secret_key_1", value: "Super Secret"
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#get_key" do
    it "retrieves a key value secret from a domain" do
      VCR.use_cassette("Commands::Authentication get_key secret_key_1", match_requests_on: [:query]) do
        response = api.get_key entityid: TEST_DOMAIN_ID, name: "secret_key_1"
        assert response.success?
        assert_equal "Super Secret", response.dig("response", "key", "value")
      end
    end
  end

  describe "#compute_hmac" do
    it "generates HMAC for a stored key/value message" do
      VCR.use_cassette("Commands::Authentication compute_hmac secret_key_1", match_requests_on: [:query]) do
        response = api.compute_hmac domainid: TEST_DOMAIN_ID, keyname: "secret_key_1", message:"my-secret-1"
        assert response.success?
        assert_includes response.dig("response", "hmac").keys, "hmac"
      end
    end
  end






end
