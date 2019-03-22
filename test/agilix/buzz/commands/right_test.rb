require "test_helper"

class Agilix::Buzz::Commands::RightTest < Minitest::Test


  describe "#create_role" do
    it "creates a role for a domain" do
      VCR.use_cassette("Commands::Right create_role for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.create_role domainid: TEST_DOMAIN_ID,  name: "Test Role", privileges: api.right_flags[:create_domain]
        assert response.success?
        assert response.dig("response", "role", "id")
      end
    end
  end

  describe "#delete_role" do
    it "deletes a roles" do
      VCR.use_cassette("Commands::Right delete_role for role #{TEST_ROLE_ID}", match_requests_on: [:query]) do
        response = api.delete_role roleid: TEST_ROLE_ID
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#delete_subscriptions" do
    it "deletes a subscription" do
      VCR.use_cassette("Commands::Right delete_subscriptions for subscription #{TEST_SUBSCRIBER_ID} for entity #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.delete_subscriptions [ {subscriberid: TEST_SUBSCRIBER_ID, entityid: TEST_DOMAIN_ID } ]
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#get_actor_rights" do
    it "gets actor rights" do
      VCR.use_cassette("Commands::Right get_actor_rights for user #{TEST_USER_ID}", match_requests_on: [:query]) do
        response = api.get_actor_rights  actorid: TEST_USER_ID, entitytypes: "U|S|D"
        assert response.success?
        assert response.dig("response", "entities")
      end
    end
  end

  describe "#get_effective_rights" do
    it "gets effective rights" do
      VCR.use_cassette("Commands::Right get_effective_rights for entity #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_effective_rights  entityid: TEST_DOMAIN_ID
        assert response.success?
        assert response.dig("response", "Authentication")
        assert_equal TEST_DOMAIN_ID, response.dig("response", "Authentication", "Authorization", "EntityId")
      end
    end
  end

  describe "#get_effective_subscription_list" do
    it "gets effective subscription list for current user" do
      VCR.use_cassette("Commands::Right get_effective_subscription_list", match_requests_on: [:query]) do
        response = api.get_effective_subscription_list
        assert response.success?
        assert response.dig("response", "subscriptions")
      end
    end
  end

  describe "#get_entity_rights" do
    it "gets entity rights" do
      VCR.use_cassette("Commands::Right get_entity_rights for entity #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_entity_rights  entityid: TEST_DOMAIN_ID
        assert response.success?
        assert users = response.dig("response", "users", "user")
        assert_equal TEST_API_USER_ID, users.first["userid"]
      end
    end
  end

  describe "#get_entity_subscription_list" do
    it "gets entity subscription list for domain" do
      VCR.use_cassette("Commands::Right get_entity_subscription_list for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_entity_subscription_list entityid: TEST_DOMAIN_ID
        assert response.success?
        assert response.dig("response", "subscriptions")
      end
    end
  end

  describe "#get_personas" do
    it "gets personas for a user" do
      VCR.use_cassette("Commands::Right get_personas for user #{TEST_API_USER_ID}", match_requests_on: [:query]) do
        response = api.get_personas userid: TEST_API_USER_ID
        assert response.success?
        assert personas = response.dig("response", "personas", "persona")
        assert_includes personas.flat_map(&:values), "Administrator"
      end
    end
  end

  describe "#get_rights" do
    it "gets rights for a user" do
      VCR.use_cassette("Commands::Right get_rights for user #{TEST_API_USER_ID} on domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_rights actorid: TEST_API_USER_ID, entityid: TEST_DOMAIN_ID
        assert response.success?
        assert rights = response.dig("response", "rights")
        assert_equal TEST_API_USER_ID, rights["actorid"]
      end
    end
  end

  describe "#get_rights_list" do
    it "gets get rights list for a domain" do
      VCR.use_cassette("Commands::Right get_rights_list for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_rights_list domainid: TEST_DOMAIN_ID
        assert response.success?
        assert rights = response.dig("response", "list", "rights")
        assert_equal TEST_DOMAIN_ID, rights.first["entitydomainid"]
      end
    end
  end

  describe "#get_role" do
    it "gets role for a user" do
      VCR.use_cassette("Commands::Right get_role for role #{TEST_ROLE_ID}", match_requests_on: [:query]) do
        response = api.get_role roleid: TEST_ROLE_ID
        assert response.success?
        assert role = response.dig("response", "role")
        assert_equal TEST_ROLE_ID, role["id"]
      end
    end
  end

  describe "#get_subscription_list" do
    it "gets get subscription list for a domain" do
      VCR.use_cassette("Commands::Right get_subscription_list for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.get_subscription_list subscriberid: TEST_DOMAIN_ID
        assert response.success?
        assert response.dig("response", "subscriptions")
      end
    end
  end

  describe "#list_roles" do
    it "lists roles" do
      VCR.use_cassette("Commands::Right list_roles for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.list_roles domainid: TEST_DOMAIN_ID
        assert response.success?
        roles = response.dig("response", "roles", "role")
        assert_kind_of Array, roles
      end
    end
  end

  describe "#restore_role" do
    it "restores a roles" do
      VCR.use_cassette("Commands::Right restore_role for role #{TEST_ROLE_ID}", match_requests_on: [:query]) do
        response = api.restore_role roleid: TEST_ROLE_ID
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#update_right" do
    it "updates a right" do
      VCR.use_cassette("Commands::Right update_rights for user #{TEST_USER_ID2} on entity #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.update_rights [ {actorid: TEST_USER_ID2, entityid: TEST_DOMAIN_ID, roleid: TEST_ROLE_ID } ]
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        assert_equal "OK", response.dig("response", "responses", "response").first["code"]
      end
    end
  end


  describe "#update_subscription" do
    it "updates a subscriptions" do
      VCR.use_cassette("Commands::Right update_subscriptions for user #{TEST_USER_ID2} on entity #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.update_subscriptions [{subscriberid: TEST_USER_ID, entityid: TEST_SOURCE_COURSE_ID, startdate: "2019-03-15", enddate: "2019-03-15"}]
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
        assert_equal "OK", response.dig("response", "responses", "response").first["code"]
      end
    end
  end

  describe "#update_role" do
    it "updates a roles" do
      VCR.use_cassette("Commands::Right update_role for role #{TEST_ROLE_ID}", match_requests_on: [:query]) do
        response = api.update_role roleid: TEST_ROLE_ID, name: "Test Role Updates", privileges: api.right_flags[:update_domain]
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end







  describe "#right_flag" do
    it "has a hash map" do
      assert_kind_of Hash, api.right_flags
      assert_equal -1, api.right_flags[:admin]
      assert_equal 40, api.right_flags.keys.count
    end
  end

  describe "#right_flags_lookup_value" do
    it "returns a right flag by hex value" do
      assert_equal :admin, api.right_flags_lookup_value("-0x01")
      assert_equal :post_domain_announcements, api.right_flags_lookup_value("0x800000000")
    end
    it "returns a right flag by integer value" do
      assert_equal :admin, api.right_flags_lookup_value(-1)
      assert_equal :post_domain_announcements, api.right_flags_lookup_value(34359738368)
    end

    it "returns an error if bad value" do
      assert_raises ArgumentError do
        api.right_flags_lookup_value(100)
      end
    end
  end

end
