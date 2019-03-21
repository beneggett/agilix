require "test_helper"

class Agilix::Buzz::Commands::RightTest < Minitest::Test


  describe "#create_role" do
    it "creates a role for a domain" do
      VCR.use_cassette("Commands::Right create_role for domain #{TEST_DOMAIN_ID}", match_requests_on: [:query]) do
        response = api.create_role domainid: TEST_DOMAIN_ID,  name: "Test Role", privileges: api.right_flags[:create_domain]
        assert response.success?
        assert response.dig("response", "role", "id")
        print response.dig("response", "role", "id")
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
    it "deletes a subscriptions" do
      skip
      VCR.use_cassette("Commands::Right delete_subscriptions for subscriptions #{TEST_ROLE_ID}", match_requests_on: [:query]) do
        response = api.delete_subscriptions sx xcv: TEST_ROLE_ID
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
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
