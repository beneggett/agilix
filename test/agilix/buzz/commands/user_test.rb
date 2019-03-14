require "test_helper"

class Agilix::Buzz::Commands::UserTest < Minitest::Test

  describe "#create_users" do
    it "creates a new user" do
      VCR.use_cassette("Commands::User create_users 1", match_requests_on: [:query]) do
        response = api.create_users [{ domainid: TEST_DOMAIN_ID, username: "BuzzUserAutoTestUser1", email: 'buzzuserautotestuser1@agilix.com', password: 'testpassword1234', firstname: 'Buzz', lastname: "Man", passwordquestion: "Who's your best friend?", passwordanswer: "Me"}]
        assert response.success?
        user_id = response.dig("response", "responses", "response").first.dig("user", "userid")
        assert user_id
      end
    end

    it "creates multiple new users" do
      VCR.use_cassette("Commands::User create_users multiple 3", match_requests_on: [:query]) do
        response = api.create_users [
          { domainid: TEST_DOMAIN_ID, username: "BuzzUserTestMultiple1", email: 'buzzusertestmultiple1@agilix.com', password: 'testpassword1234', firstname: 'Buzz', lastname: "Jones"},
          { domainid: TEST_DOMAIN_ID, username: "BuzzUserTestMultiple2", email: 'buzzusertestmultiple2@agilix.com', password: 'testpassword1234', firstname: 'Buzz', lastname: "Michaels"},
          { domainid: TEST_DOMAIN_ID, username: "BuzzUserTestMultiple3", email: 'buzzusertestmultiple3@agilix.com', password: 'testpassword1234', firstname: 'Buzz', lastname: "Aldrin"}
        ]
        assert response.success?
        users = response.dig("response", "responses", "response")
        assert_equal 3, users.count
      end
    end
  end

  describe "#delete_users" do
    it "deletes a new user" do
      VCR.use_cassette("Commands::User delete_users", match_requests_on: [:query]) do
        response = api.delete_users [{ userid: '57181'}]
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


end
