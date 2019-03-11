require "test_helper"

class Agilix::Buzz::Commands::DomainTest < Minitest::Test

  describe "#create_domains" do
    it "creates a new domain" do
      VCR.use_cassette("Commands::Domain create_domains", match_requests_on: [:query]) do
        response = api.create_domains [{name: "BuzzAutoTest001", userspace: 'buzz-test-fc-auto-test-001', parentid: "57025"}]
        assert response.success?
        domain_id = response.dig("response", "responses", "response").first.dig("domain", "domainid")
        assert domain_id
      end
    end

    it "creates multiple new domains" do
      VCR.use_cassette("Commands::Domain create_domains multiple", match_requests_on: [:query]) do
        response = api.create_domains [{name: "BuzzAutoTestMultiple1", userspace: 'buzz-test-fc-auto-test-multiple1', parentid: "57025"},{name: "BuzzAutoTestMultiple2", userspace: 'buzz-test-fc-auto-test-multiple2', parentid: "57025"},{name: "BuzzAutoTestMultiple3", userspace: 'buzz-test-fc-auto-test-multiple3', parentid: "57025"}]
        assert response.success?
        domains = response.dig("response", "responses", "response")
        assert_equal 3, domains.count
      end
    end
  end

  describe "#delete_domain" do
    it "deletes a domain" do
      VCR.use_cassette("Commands::Domain delete_domain", match_requests_on: [:query]) do
       response =  api.delete_domain domainid: "57031"
       assert response.success?
       assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#get_domain2" do
    it "looks up a domain" do
      VCR.use_cassette("Commands::Domain get_domain 57025", match_requests_on: [:query]) do
        response = api.get_domain domainid: "57025"
        assert response.success?
        assert_equal "auto-tests", response.dig("response", "domain", "userspace")
      end
    end
  end

  describe "#get_domain_content" do
    it "gets content for a domain" do
      VCR.use_cassette("Commands::Domain get_domain_content", match_requests_on: [:query]) do
        response = api.get_domain_content domainid: "57025"
        assert response.success?
        assert_empty response.dig("response", "domain", "announcements")
      end
    end
  end

  describe "#get_domain_enrollment_metrics" do
    it "gets enrollment metrics" do
      VCR.use_cassette("Commands::Domain get_domain_enrollment_metrics", match_requests_on: [:query]) do
        response = api.get_domain_enrollment_metrics domainid: "57025"
        assert response.success?
        assert_equal "57025", response.dig("response", "domainenrollmentmetrics", "domainid")
      end
    end
  end

  describe "#get_domain_parent_list" do
    it "looks up parents for a domain" do
      VCR.use_cassette("Commands::Domain get_domain_parent_list 57032", match_requests_on: [:query]) do
        response = api.get_domain_parent_list domainid: "57032"
        assert response.success?
        assert_equal "57025", response.dig("response", "domains", "domain").first["domainid"]
      end
    end
  end

  describe "#get_domain_settings" do
    it "looks up a settings string for a domain" do
      VCR.use_cassette("Commands::Domain get_domain_settings", match_requests_on: [:query]) do
        response = api.get_domain_settings domainid: "57025", path: "AgilixBuzzSettings.xml"
        assert response.success?
        assert_equal 57025, response.dig("response", "settings", "domainid")
      end
    end
  end

  describe "#get_domain_stats" do
    it "gets domain stats" do
      VCR.use_cassette("Commands::Domain get_domain_stats for 57025", match_requests_on: [:query]) do
        response = api.get_domain_stats domainid: "57025", options: "users|courses"
        assert response.success?
        ["users", "courses"].map do |stat|
          assert_includes response.dig("response", "stats", "stat").map {|stat| stat["name"]}, stat
        end
      end
    end
  end

  describe "#restore_domain" do
    it "restores a deleted domain" do
      VCR.use_cassette("Commands::Domain restore_domain 57031", match_requests_on: [:query]) do
        response = api.restore_domain domainid: '57031'
        assert response.success?
        assert_equal "OK", response.dig("response", "code")
      end
    end
  end

  describe "#update_domains" do
    it "updates domain attributes" do
      VCR.use_cassette("Commands::Domain update_domains", match_requests_on: [:query]) do
        response = api.update_domains [{ domainid: "57025", name: "BuzzTestUpdatedName1" }]
        assert response.success?
        updated_domains = response.dig("response", "responses", "response")
        assert_equal 1, updated_domains.count
      end
    end
  end

  describe '#list_domains' do
    it "Returns a list of domains by id " do
      VCR.use_cassette("Commands::Domain list_domains", match_requests_on: [:query]) do
        response = api.list_domains domainid: "57025", includedescendantdomains: true
        assert response.success?
        assert response.dig('response', 'domains', 'domain').present?
        assert response.dig('response', 'domains', 'domain').sample["name"]
      end
    end

    it "Returns a list of all domains" do
      VCR.use_cassette("Commands::Domain list_domains all", match_requests_on: [:query]) do
        response = api.list_domains domainid: '0'
        assert response.success?
        assert response.dig('response', 'domains', 'domain').present?
        assert response.dig('response', 'domains', 'domain').sample["name"]
      end
    end
  end


end
