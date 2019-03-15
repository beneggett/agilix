require "test_helper"

class Agilix::Buzz::Commands::UserTest < Minitest::Test

  describe "#create_users" do
    it "creates a new user" do
      VCR.use_cassette("Commands::User create_users 1", match_requests_on: [:query]) do
        response = api.create_users [{ domainid: TEST_SUBDOMAIN_ID, username: "BuzzUserAutoTestUser1", email: 'agilixbuzzuserautotestuser1@agilix.com', password: 'testpassword1234', firstname: 'Buzz', lastname: "Man", passwordquestion: "Who's your best friend?", passwordanswer: "Me"}]
        assert response.success?
        user_id = response.dig("response", "responses", "response").first.dig("user", "userid")
        assert user_id
      end
    end

    it "creates multiple new users" do
      VCR.use_cassette("Commands::User create_users multiple 3", match_requests_on: [:query]) do
        response = api.create_users [
          { domainid: TEST_DOMAIN_ID, username: "BuzzUserTestMultiple1", email: 'agilixbuzzusertestmultiple1@agilix.com', password: 'testpassword1234', firstname: 'Buzz', lastname: "Jones"},
          { domainid: TEST_DOMAIN_ID, username: "BuzzUserTestMultiple2", email: 'agilixbuzzusertestmultiple2@agilix.com', password: 'testpassword1234', firstname: 'Buzz', lastname: "Michaels"},
          { domainid: TEST_DOMAIN_ID, username: "BuzzUserTestMultiple3", email: 'agilixbuzzusertestmultiple3@agilix.com', password: 'testpassword1234', firstname: 'Buzz', lastname: "Aldrin"}
        ]
        assert response.success?
        users = response.dig("response", "responses", "response")
        assert_equal 3, users.count
      end
    end
  end

  describe "#delete_users" do
    it "deletes a new user" do
      VCR.use_cassette("Commands::User delete_users #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.delete_users [{ userid: TEST_USER_ID}]
        assert response.success?
        response_code = response.dig("response", "responses", "response").first.dig("code")
        assert_equal "OK", response_code
      end
    end

    it "deletes multiple users" do
      VCR.use_cassette("Commands::User delete_users multiple", match_requests_on: [:query]) do
        response = api.delete_users [
          { userid: '57179'},
          { userid: '57180'},
        ]
        assert response.success?
        responses = response.dig("response", "responses", "response")
        assert_equal 2, responses.count
        response_codes = responses.map {|r| r["code"]}
        response_codes.each do |code|
          assert_equal "OK", code
        end
      end
    end
  end

  describe "#get_active_user_count" do
    it "gets active user stats for a domain" do
      VCR.use_cassette("Commands::User get_active_user_count for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_active_user_count domainid: TEST_DOMAIN_ID, includedescendantdomains: true
        assert response.success?
        activity = response.dig("response", "activity")
        assert_includes activity.keys, "activeusers"
      end
    end
  end


  describe "#get_domain_activity" do
    it "gets domain activity login stats for a domain" do
      VCR.use_cassette("Commands::User get_domain_activity for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_domain_activity domainid: TEST_DOMAIN_ID
        assert response.success?
        users = response.dig("response", "users", "user")
        assert_equal 1, users.count
      end
    end
  end

  describe "#get_profile_picture" do
    it "gets domain activity login stats for a domain" do
      VCR.use_cassette("Commands::User get_profile_picture for user #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.get_profile_picture entityid: TEST_USER_ID, default: "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm"
        assert response.success?
        assert_equal "image/jpeg", response.content_type
      end
    end
  end

  describe "#get_user" do
    it "gets user" do
      VCR.use_cassette("Commands::User get_user for user #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.get_user2 userid: TEST_USER_ID
        assert response.success?
        user = response.dig("response", "user")
        assert_equal TEST_USER_ID, user["id"]
      end
    end
  end

  describe "#get_user_activity" do
    it "gets user login activity" do
      VCR.use_cassette("Commands::User get_user_activity for user #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.get_user_activity userid: TEST_USER_ID
        assert response.success?
        assert_kind_of Hash, response.dig("response", "log")
      end
    end
  end

  describe "#get_user_activity_stream" do
    it "gets user login get_user_activity_stream" do
      VCR.use_cassette("Commands::User get_user_activity_stream for user #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.get_user_activity_stream userid: TEST_USER_ID
        assert response.success?
        activities = response.dig("response","activities")
        assert_kind_of Hash, activities
      end
    end
  end

  describe "#list_users" do
    it "gets list of users for a domain" do
      VCR.use_cassette("Commands::User list_users for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.list_users domainid: TEST_DOMAIN_ID
        assert response.success?
        users = response.dig("response", "users", "user")
        assert_kind_of Array, users
        assert_equal TEST_DOMAIN_ID, users.sample["domainid"] if users.any?
      end
    end
  end

  describe "#restore_user" do
    it "restores a user" do
      VCR.use_cassette("Commands::User restore_user #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.restore_user userid: TEST_USER_ID
        assert response.success?
        response_code = response.dig("response", "code")
        assert_equal "OK", response_code
      end
    end
  end


  describe "#update_users" do
    it "updates user attributes" do
      VCR.use_cassette("Commands::Domain update_users #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.update_users [{ userid: TEST_USER_ID, username: "BuzzUserUp1", email: 'buzzusertest1@agilix.com', firstname: 'Buzz', lastname: "ManUpdated"}]
        assert response.success?
        updated_users = response.dig("response", "responses", "response")
        assert_equal 1, updated_users.count
      end
    end
  end

end
